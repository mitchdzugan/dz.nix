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
  command: [
    "set-theme",
    "get-brightness",
    "toggle-brightness",
    "get-vim",
    "get-tmux",
    null,
  ],
};
const shortHands = {
  light: ["--brightness", "light"],
  l: ["--brightness", "light"],
  dark: ["--brightness", "dark"],
  d: ["--brightness", "dark"],
  toggle: ["--command", "toggle-brightness"],
  t: ["--command", "toggle-brightness"],
  ":brightness": ["--command", "get-brightness"],
  ":b": ["--command", "get-brightness"],
  ":vim": ["--command", "get-vim"],
  ":v": ["--command", "get-vim"],
  ":tmux": ["--command", "get-tmux"],
  ":t": ["--command", "get-tmux"],
};
const opts = nopt(knownOpts, shortHands, process.argv, 2);

const paths = envPaths("dz-theme", { suffix: "" });

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

async function setTheme(theme) {
  await spit(dataPath("theme"), theme.id);
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

const DEFAULT_THEME = {
  name: "clay dark",
  isDark: true,
  vim: "monet",
  kitty: "selenized-black",
  plasma: "ClayDark",
  accent: "#A85CB8",
  id: "clay-dark",
};

async function getCfg() {
  try {
    return toml.parse(await slurp(cfgPath("themes.toml")));
  } catch (_e) {
    return { theme: { DEFAULT_THEME } };
  }
}

function getPreferredTheme(viable) {
  let best = viable[0];
  if (!best) {
    return;
  }
  for (const theme of viable) {
    if (getPreference(theme) > getPreference(best)) {
      best = theme;
    }
  }
  return best;
}

async function setThemeCmd() {
  const cfg = await getCfg();
  for (const themeId in cfg.theme) {
    cfg.theme[themeId].id = themeId;
  }
  const viable = Object.values(cfg.theme).filter(
    (t) =>
      !opts.brightness || opts.brightness === (t.isDark ? "dark" : "light"),
  );
  await setTheme(getPreferredTheme(viable));
}

async function getActiveTheme() {
  const cfg = await getCfg();
  const dataTheme = await slurp(dataPath("theme")).then((s) => s.trim());
  return cfg.theme[dataTheme] || getPreferredTheme(Object.values(cfg.theme));
}

async function getIsDark() {
  const sshBrightness = process.env["DZ_SSH_BRIGHTNESS"];
  return sshBrightness
    ? sshBrightness === "dark"
    : await getActiveTheme().then((theme) => theme.isDark);
}

async function getBrightnessCmd() {
  console.log((await getIsDark()) ? "dark" : "light");
}

async function getVimCmd() {
  console.log(
    process.env["DZ_SSH_VIM"] ||
      (await getActiveTheme().then((theme) => theme.vim)),
  );
}

async function getTmuxCmd() {
  console.log(
    process.env["DZ_SSH_TMUX"] ||
      (await getActiveTheme().then((theme) => theme.tmux)),
  );
}

async function toggleBrightnessCmd() {
  const isDark = await getIsDark();
  opts.brightness = isDark ? "light" : "dark";
  await setThemeCmd();
}

async function main() {
  const command = opts.command || "set-theme";
  if (command === "set-theme") {
    await setThemeCmd();
  } else if (command === "get-tmux") {
    await getTmuxCmd();
  } else if (command === "get-vim") {
    await getVimCmd();
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
