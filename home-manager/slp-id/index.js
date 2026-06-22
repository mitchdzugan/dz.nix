#!/usr/bin/env node

import * as fs from "node:fs/promises";
import * as Slp from "@dz/slp-lib";

async function main() {
  const filename = process.argv[2];
  const buffer = await fs.readFile(filename || "");
  const game = Slp.parseIntakeGame(buffer);
  console.log(game.game.game_id);
}

main()
  .then(() => process.exit())
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
