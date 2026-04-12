#!/usr/bin/env node

import * as fs from "node:fs/promises";
import path from "node:path";
import { mkdirp } from "mkdirp";
import envPaths from "env-paths";

async function pageReturnsHtml(url) {
  try {
    const fetchRes = await fetch(url);
    const body = await fetchRes.text();
    return typeof body === "string" && fetchRes.status === 200;
  } catch (_e) {
    return false;
  }
}

const paths = envPaths("dz-status", { suffix: "" });

const STATUS = {
  OK: "😄",
  UNKNOWN: "🤔",
  ISSUE: "😨",
};

const ALL_STATUS_STRS = new Set(Object.values(STATUS));

function getStatusFile(key) {
  return path.join(paths.data, key);
}

async function getLastStatusData(key) {
  const statusFile = getStatusFile(key);
  try {
    const content = await fs.readFile(statusFile, "utf8");
    const currentStatus = content.trim();
    if (!ALL_STATUS_STRS.has(currentStatus)) {
      return [];
    }
    const stats = await fs.stat(statusFile);
    const now = new Date().valueOf();
    const minsAgo = (now - stats.mtimeMs) / 1000 / 60;
    return [currentStatus, minsAgo];
  } catch (_e) {
    return [];
  }
}

async function getPusdbStatus() {
  try {
    const url = "https://slp-db.public-universal-domain.org/checkhealth";
    const res = await fetch(url);
    const { ok } = await res.json();
    return ok ? STATUS.OK : STATUS.ISSUE;
  } catch (_e) {
    return STATUS.ISSUE;
  }
}

const slippiClmDataUrl = [
  "https://raw.githubusercontent.com",
  "slippi-clm/slippi-clm.github.io/refs/heads/main/data.json",
].join("/");

async function getSlippiClmStatus() {
  try {
    const fetchRes = await fetch(slippiClmDataUrl);
    return await fetchRes
      .json()
      .then(({ updatedAt }) => {
        const timeSinceUpdate = new Date().valueOf() - updatedAt * 1000;
        const minsSinceUpdate = timeSinceUpdate / 1000 / 60;
        return minsSinceUpdate > 80 ? STATUS.ISSUE : STATUS.OK;
      })
      .catch(() => STATUS.ISSUE);
  } catch (e) {
    return STATUS.UNKNOWN;
  }
}
async function getClmStatsStatus() {
  try {
    const url = "https://clm.public-universal-domain.org/checkhealth";
    const res = await fetch(url);
    const { ok } = await res.json();
    return ok ? STATUS.OK : STATUS.ISSUE;
  } catch (_e) {
    return STATUS.ISSUE;
  }
}

async function getDzMediaStatus() {
  const isOnline = await pageReturnsHtml("https://media.dz-stuff.org");
  return isOnline ? STATUS.OK : STATUS.ISSUE;
}

const Keys = {
  SlippiClm: { label: "🐸", getStatus: getSlippiClmStatus },
  Pusdb: { label: "💽", getStatus: getPusdbStatus },
  ClmStats: { label: "🔧", getStatus: getClmStatsStatus },
  DzMedia: { label: "🍿", getStatus: getDzMediaStatus },
};

for (const k in Keys) {
  Keys[k].key = k;
}

const networkChecker = new (class {
  constructor() {
    this.didCheck = false;
  }

  get isOk() {
    if (this.didCheck) {
      return Promise.resolve(this.wasOk);
    }
    return new Promise(async (resolve) => {
      this.wasOk = await pageReturnsHtml("https://www.google.com/");
      this.didCheck = true;
      resolve(this.wasOk);
    });
  }
})();

async function mkStatus(key) {
  const [lastStatus, lastStatusTime] = await getLastStatusData(key);
  if (lastStatus === STATUS.OK && lastStatusTime < 10) {
    return lastStatus;
  }
  if (lastStatus && lastStatusTime < 1) {
    return lastStatus;
  }
  const { getStatus } = Keys[key];
  let status = STATUS.UNKNOWN;
  try {
    const networkIsOk = await networkChecker.isOk;
    status = !networkIsOk ? STATUS.UNKNOWN : await getStatus();
  } catch (_e) {}
  const statusFile = getStatusFile(key);
  await fs.rm(statusFile).catch(() => {});
  await fs.writeFile(statusFile, status);
  return status;
}

async function mkStatusLine(key) {
  const { label } = Keys[key];
  const status = await mkStatus(key);
  return `(${label}${status})`;
}

async function main() {
  await mkdirp(paths.data);
  const statusLines = await Promise.all([
    Promise.resolve(" "),
    mkStatusLine(Keys.SlippiClm.key),
    mkStatusLine(Keys.Pusdb.key),
    mkStatusLine(Keys.ClmStats.key),
    mkStatusLine(Keys.DzMedia.key),
    Promise.resolve(" "),
  ]);
  console.log(statusLines.join(" "));
}

main()
  .then(() => process.exit())
  .catch(() => process.exit(1));
