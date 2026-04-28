{ pkgs, ... }: pkgs.buildNpmPackage {
  pname = "dz-dev";
  version = "1.0.0";
  src = ./.;
  npmDepsHash = "sha256-a06Pzbp5xNxualudveTQ3db+6IPhUwkj8xKvJIwj4/Q=";
}
