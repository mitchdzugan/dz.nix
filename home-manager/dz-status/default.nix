{ pkgs, ... }: pkgs.buildNpmPackage {
  pname = "dz-status";
  version = "1.0.0";
  src = ./.;
  npmDepsHash = "sha256-qM+G8ghqQ/szAfZXtsBuYmVgbX2dmZu2UHX8oGSACbQ=";
}
