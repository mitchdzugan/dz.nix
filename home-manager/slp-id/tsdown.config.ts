import { defineConfig } from "tsdown";

export default defineConfig([
  {
    entry: ["index.js"],
    dts: true,
    format: ["esm"],
    hash: false,
    fixedExtension: true,
    clean: true,
    minify: true,
    deps: {
      alwaysBundle: () => true,
    },
  },
]);
