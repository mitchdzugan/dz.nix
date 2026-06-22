import * as fs from "node:fs/promises";
import { parseIntakeGame } from "#lib/slp.js";

async function main() {
  const filename = process.argv[2];
  const buffer = await fs.readFile(filename || "");
  const game = parseIntakeGame(buffer);
  console.log(game.game.game_id);
}

main()
  .then(() => process.exit())
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
