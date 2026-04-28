{ pkgs, ... }: pkgs.buildNpmPackage {
  pname = "dz-ytmdl";
  version = "1.0.0";
  src = ./.;
  npmDepsHash = "sha256-wzRp7i0Bj5SOk3MiwGDAowDtEAqI3Nd7pHLj98J1GB0=";
}
