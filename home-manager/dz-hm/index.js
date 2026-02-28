#!/usr/bin/env node

import * as fs from "node:fs/promises";
import path from "node:path";
import { mkdirp } from "mkdirp";
import { execa } from "execa";
import nopt from "nopt";
import chalk from "chalk";

function $(...rawTopArgs) {
  rawTopArgs.reverse();
  const [arg0, ...fns] = rawTopArgs;
  fns.reverse();
  let res = arg0;
  for (const fn of fns) {
    res = fn(res);
  }
  return res;
}

const { cyan, magenta, bold, gray, green, red } = chalk;

const knownOpts = {
  command: ["switch", null],
};
const shortHands = {
  switch: ["--command", "switch"],
};
const opts = nopt(knownOpts, shortHands, process.argv, 2);

const homePath = (...args) => path.join(process.env.HOME, ...args);
const configPath = (...args) => homePath(".config", ...args);
const hmPath = (...args) => configPath("home-manager", ...args);
const dzNixPath = (...args) => hmPath("dz.nix", ...args);

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

async function execWithInheritedIO(cmd, a2, a3) {
  const args = Array.isArray(a2) ? a2 : [];
  const baseOpts = (Array.isArray(a2) ? a3 : a2) || {};
  const opts = { ...baseOpts, stdout: "inherit", stderr: "inherit" };
  return await execa(cmd, args, opts);
}

const info = (...args) =>
  console.log(
    [$(bold, gray, "["), $(bold, magenta, "󰬇"), $(bold, gray, "]")].join(""),
    args.join(""),
  );

let depth = 0;
async function installIfNeeded(name, cond, action) {
  let pad = "";
  for (let i = 0; i < depth; i++) {
    pad += "    ";
  }
  depth++;
  const $name = $(bold, cyan, name);
  info(pad, "checking if ", $name, " is installed...");
  let res = undefined;
  const subInfo = (...args) => info(pad, gray("⦿ "), $name, " ", ...args);
  if (await cond()) {
    subInfo($(bold, green, "✔"));
  } else {
    subInfo($(bold, red, "✗"), " installing now...");
    res = await action();
  }
  depth--;
  return res;
}

const execOut = (...args) => execa(...args).then((res) => res.stdout);

async function hasHMChannel() {
  const stdout = await execOut("nix-channel", ["--list"]);
  for (const line of (stdout || "").split("\n")) {
    if (/^home-manager(\s+)(.+)/.test(line)) {
      return true;
    }
  }
  return false;
}

const hmUrl =
  "https://github.com/nix-community/home-manager/archive/master.tar.gz";

async function addHMChannel() {
  await execWithInheritedIO("nix-channel", ["--add", hmUrl, "home-manager"]);
  await execWithInheritedIO("nix-channel", ["--update"]);
}

async function isHMInstalled() {
  try {
    await execa("which", ["home-manager"]);
    return true;
  } catch (_e) {
    return false;
  }
}

async function installHM() {
  await installIfNeeded("home-manager:nix-channel", hasHMChannel, addHMChannel);
  await execWithInheritedIO("nix-shell", ["<home-manager>", "-A", "install"]);
}

const fnCond =
  (...args) =>
  () =>
    exists(...args);

async function initThisDotNix() {
  const username = await execOut("whoami").then((s) => s.trim());
  const homeDirectory = process.env["HOME"];
  const stateVersion = await (async () => {
    try {
      const hmFile = await slurp(hmPath("home.nix"));
      for (const line of hmFile.split("\n")) {
        if (line.includes("home.stateVersion")) {
          return JSON.parse(line.split("=")[1].split(";")[0].trim());
        }
      }
    } catch (_e) {
      return "25.11";
    }
  })();
  const content = [
    "{",
    `  username ="${username}";`,
    `  homeDirectory ="${homeDirectory}";`,
    `  stateVersion ="${stateVersion}";`,
    `  defaultNixGLWrapper ="mesa";`,
    "}",
  ].join("\n");
  await spit(hmPath("this.nix"), content);
}

async function setHomeManagerFlakeDotNix() {
  const username = await execOut("whoami").then((s) => s.trim());
  // const hasLocal = await exists(dzNixPath("flake.nix"));
  // const dzNixUrl = hasLocal ? "path:./dz.nix" : "github:mitchdzugan/dz.nix";
  const dzNixUrl = "path:./dz.nix";
  const content = [
    "{",
    `  description = "Home Manager configuration";`,
    `  inputs = {`,
    '    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";',
    '    home-manager.url = "github:nix-community/home-manager";',
    '    home-manager.inputs.nixpkgs.follows = "nixpkgs";',
    `    dz-nix.url = "${dzNixUrl}";`,
    '    dz-nix.inputs.nixpkgs.follows = "nixpkgs";',
    `  };`,
    "  outputs = { nixpkgs, home-manager, dz-nix, ... }: {",
    `    homeConfigurations."${username}" = home-manager.lib.homeManagerConfiguration {`,
    "      pkgs = nixpkgs.legacyPackages.x86_64-linux;",
    "      modules = [(dz-nix.mk-home-manager (import ./this.nix))];",
    "    };",
    "  };",
    "}",
  ].join("\n");
  await spit(hmPath("flake.nix"), content);
}

async function cloneDzNix() {
  await execWithInheritedIO(
    "git",
    ["clone", "--recurse-submodules", "https://github.com/mitchdzugan/dz.nix"],
    { cwd: hmPath() },
  );
}

async function switchCmd() {
  console.log("switching...");
  await installIfNeeded("home-manager", isHMInstalled, installHM);
  await installIfNeeded("this.nix", fnCond(hmPath("this.nix")), initThisDotNix);
  await installIfNeeded("dz.nix", fnCond(dzNixPath("flake.nix")), cloneDzNix);
  await setHomeManagerFlakeDotNix();
  await execWithInheritedIO("home-manager", ["switch"]);
}

async function main() {
  if (opts.command === "switch") {
    await switchCmd();
  } else {
    throw `unknown cmd:  [ ${opts.command || "NO COMMAND GIVEN"} ]`;
  }
}

main()
  .then(() => process.exit())
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
