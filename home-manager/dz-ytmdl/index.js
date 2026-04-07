#!/usr/bin/env node

import * as fs from "node:fs/promises";
import path from "node:path";
import envPaths from "env-paths";
import { mkdirp } from "mkdirp";
import { execa } from "execa";
import * as toml from "smol-toml";
import nopt from "nopt";
import { parseFile } from "music-metadata";
import { rimraf } from "rimraf";
import ffmetadata from "ffmetadata";

const musicPath = (...rest) => path.join("/VOID/media/music/", ...rest);

const songDstPath = (artist, album, song) => musicPath(artist, album, song);

const knownOpts = {
  command: ["add", "fix", null],
};
const shortHands = {
  fix: ["--command", "fix"],
  f: ["--command", "fix"],
};
const opts = nopt(knownOpts, shortHands, process.argv, 2);

const paths = envPaths("dz-ytdlp", { suffix: "" });

const cfgPath = (...args) => path.join(paths.config, ...args);
const dataPath = (...args) => path.join(paths.data, ...args);
const xdgPath = (...args) => cfgPath("..", ...args);

const exists = (p) =>
  fs
    .access(p, fs.constants.F_OK)
    .then(() => true)
    .catch(() => false);

const rm = (p) =>
  fs
    .rm(p)
    .then(() => true)
    .catch(() => false);

const spit = (p, s) =>
  mkdirp(path.dirname(p))
    .then(() => fs.writeFile(p, s || ""))
    .then(() => true)
    .catch(() => false);

const slurp = (p) => fs.readFile(p, "utf-8").catch(() => "");

async function addCmd() {
  const { remain } = opts.argv;
  const pid = process.pid;
  const now = Date.now();
  const uuid = `${pid}_${now}`;
  const cwd = dataPath(uuid);
  await mkdirp(cwd);
  const dlpArgs = [
    "--extract-audio",
    "-t",
    "aac",
    "--embed-metadata",
    "--add-metadata",
    "--parse-metadata",
    "%(playlist_index)s:%(track_number)s",
    "--embed-thumbnail",
    "--convert-thumbnails",
    "jpg",
    "-o",
    "%(channel)s/%(title)s",
    ...remain,
  ];
  await execa("yt-dlp", dlpArgs, {
    cwd,
    stdout: ["pipe", "inherit"],
    stderr: ["pipe", "inherit"],
  });
  const albumArtists = await fs.readdir(cwd);
  for (const albumArtist of albumArtists) {
    if (albumArtist == ".." || albumArtist == ".") {
      continue;
    }
    const albumArtistPath = path.join(cwd, albumArtist);
    const songs = await fs.readdir(albumArtistPath);
    for (const song of songs) {
      const artist = albumArtist === "NA" ? "Unknown Artist" : albumArtist;
      const fullPath = path.join(albumArtistPath, song);
      const metadata = await parseFile(fullPath);
      const rawAlbum = metadata.common.album || "NA";
      const album = rawAlbum === "NA" ? "Unknown Album" : rawAlbum;
      console.log({ artist, album, song });
      const dstPath = songDstPath(artist, album, song);
      await mkdirp(path.dirname(dstPath));
      await fs.copyFile(fullPath, dstPath);
    }
  }
  await rimraf(cwd);
}

const FIXED_ALBUM_ARTIST_BY_ALBUM = {
  "Wicked: The Soundtrack": "Wicked Movie Cast",
  "Wicked: For Good – The Soundtrack": "Wicked Movie Cast",
  "Wicked: One Wonderful Night (Live) – The Soundtrack": "Wicked Movie Cast",
};

async function fixCmd() {
  const albumArtists = await fs.readdir(musicPath());
  const albumArtistCountsByAlbum = {};
  for (const albumArtistRaw of albumArtists) {
    const albumArtist = albumArtistRaw.endsWith(" - Topic")
      ? albumArtistRaw.substring(0, albumArtistRaw.length - 8)
      : albumArtistRaw;
    if (albumArtistRaw !== albumArtist) {
      await fs.rename(musicPath(albumArtistRaw), musicPath(albumArtist));
    }
    const albums = await fs.readdir(musicPath(albumArtist));
    for (const album of albums) {
      const songs = await fs.readdir(musicPath(albumArtist, album));
      albumArtistCountsByAlbum[album] ||= {};
      albumArtistCountsByAlbum[album][albumArtist] = songs.length;
    }
  }

  const albumArtistByAlbum = { ...FIXED_ALBUM_ARTIST_BY_ALBUM };
  for (const album in albumArtistCountsByAlbum) {
    if (albumArtistByAlbum[album]) {
      continue;
    }
    const albumArtists = Object.keys(albumArtistCountsByAlbum[album]);
    let best = albumArtists[0];
    let bestCount = albumArtistCountsByAlbum[album][best];
    for (const albumArtist of albumArtists) {
      const count = albumArtistCountsByAlbum[album][albumArtist];
      if (count > bestCount) {
        best = albumArtist;
        bestCount = count;
      }
    }
    albumArtistByAlbum[album] = best;
  }

  const albumArtists2 = await fs.readdir(musicPath());
  for (const albumArtistRaw of albumArtists2) {
    let movedAll = true;
    const albums = await fs.readdir(musicPath(albumArtistRaw));
    for (const album of albums) {
      const albumArtist = albumArtistByAlbum[album];
      if (albumArtist !== albumArtistRaw) {
        const songs = await fs.readdir(musicPath(albumArtistRaw, album));
        await mkdirp(musicPath(albumArtist, album));
        for (const song of songs) {
          await fs.rename(
            musicPath(albumArtistRaw, album, song),
            musicPath(albumArtist, album, song),
          );
        }
      } else {
        movedAll = false;
      }
    }
    if (movedAll) {
      await rimraf(musicPath(albumArtistRaw));
    }
  }

  const albumArtists3 = await fs.readdir(musicPath());
  for (const albumArtist of albumArtists3) {
    const albums = await fs.readdir(musicPath(albumArtist));
    for (const album of albums) {
      const songs = await fs.readdir(musicPath(albumArtist, album));
      for (const song of songs) {
        console.log([albumArtist, album, song]);
        const songPath = musicPath(albumArtist, album, song);
        await new Promise((resolve, reject) => {
          ffmetadata.read(songPath, (err, data) => {
            if (err) {
              reject(err);
            }
            console.log(data);
            const finData = { ...data, album_artist: albumArtist };
            ffmetadata.write(songPath, finData, (err) => {
              if (err) {
                reject(err);
              }
              resolve();
            });
          });
        });
      }
    }
  }
}

async function main() {
  const command = opts.command || "add";
  if (command === "add") {
    await addCmd();
  } else if (command === "fix") {
    await fixCmd();
  }
}

main()
  .then(() => process.exit())
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
