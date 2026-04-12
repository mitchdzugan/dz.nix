{ pkgs, ... }: pkgs.mkYarnPackage {
  name = "dz-status";
  src = ./.;
  packageJSON = ./package.json;
  yarnLock = ./yarn.lock;
  yarnNix = ./yarn.nix;
}
