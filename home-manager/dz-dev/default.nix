{ pkgs, ... }: pkgs.mkYarnPackage {
  name = "dz-dev";
  src = ./.;
  packageJSON = ./package.json;
  yarnLock = ./yarn.lock;
  yarnNix = ./yarn.nix;
}
