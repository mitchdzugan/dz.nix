#!/usr/bin/env node

import * as fs from "node:fs/promises";
import path from "node:path";
import envPaths from "env-paths";
import { mkdirp } from "mkdirp";
import { execa } from "execa";
import * as toml from "smol-toml";
import nopt from "nopt";

const knownOpts = { brightness: ["dark", "light", null] };
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

async function main() {
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

main()
  .then(() => process.exit())
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
