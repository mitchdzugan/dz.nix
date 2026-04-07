#!/usr/bin/env node

import * as fs from "node:fs/promises";
import path from "node:path";
import envPaths from "env-paths";
import { mkdirp } from "mkdirp";
import { execa } from "execa";
import * as toml from "smol-toml";
import nopt from "nopt";

const knownOpts = {
  command: [
    "serve",
    "query",
    null,
  ],
};
const shortHands = {
  serve: ["--command", "serve"],
  s: ["--command", "serve"],
};
const opts = nopt(knownOpts, shortHands, process.argv, 2);
const paths = envPaths("dz-dev", { suffix: "" });
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

async function main() {
  const command = opts.command || "query";
  if (command === "serve") {
    console.log("serving...");
  } else if (command === "query") {
    console.log("querying...");
  } else {
    throw `unknown command ${command}`;
  }
}

main()
  .then(() => process.exit())
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
