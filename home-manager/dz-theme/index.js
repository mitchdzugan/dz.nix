#!/usr/bin/env node

import * as fs from "node:fs/promises";
import path from "node:path";
import envPaths from "env-paths";
import { mkdirp } from "mkdirp";
import { execa } from "execa";
import * as toml from "smol-toml";
import nopt from "nopt";

const knownOpts = {
  brightness: ["dark", "light", null],
  command: ["set-theme", "get-brightness", "toggle-brightness", null],
};
const shortHands = {
  light: ["--brightness", "light"],
  l: ["--brightness", "light"],
  dark: ["--brightness", "dark"],
  d: ["--brightness", "dark"],
};
const opts = nopt(knownOpts, shortHands, process.argv, 2);

const paths = envPaths("dz-theme", { suffix: "" });

const cfgPath = (...args) => path.join(paths.config, ...args);
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

async function setTheme(theme) {
  await (theme.isDark ? spit : rm)(cfgPath("dark"));
  await spit(cfgPath("vim"), theme.vim);
  await spit(
    xdgPath("kitty", "current-theme.conf"),
    await slurp(cfgPath("kitty", `${theme.kitty}.conf`)),
  );
  await execa("plasma-apply-colorscheme", [theme.plasma]);
  await execa("plasma-apply-colorscheme", ["--accent-color", theme.accent]);
  await execa("pkill", ["-SIGUSR1", "kitty"]);
}

function getPreference(theme) {
  return theme.preference || 0;
}

async function setThemeCmd() {
  const { theme } = toml.parse(await slurp(cfgPath("themes.toml")));
  const viable = Object.values(theme).filter(
    (t) =>
      !opts.brightness || opts.brightness === (t.isDark ? "dark" : "light"),
  );
  let best = viable[0];
  if (!best) {
    return;
  }
  for (const theme of viable) {
    if (getPreference(theme) > getPreference(best)) {
      best = theme;
    }
  }
  await setTheme(best);
}

async function getBrightnessCmd() {
  const isDark = await exists(cfgPath("dark"));
  console.log(isDark ? "dark" : "light");
}

async function toggleBrightnessCmd() {
  const isDark = await exists(cfgPath("dark"));
  opts.brightness = isDark ? "light" : "dark";
  await setThemeCmd();
}

async function main() {
  const command = opts.command || "set-theme";
  if (command === "set-theme") {
    await setThemeCmd();
  } else if (command === "get-brightness") {
    await getBrightnessCmd();
  } else if (command === "toggle-brightness") {
    await toggleBrightnessCmd();
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
