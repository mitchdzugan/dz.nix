{ pkgs, ... }: pkgs.mkYarnPackage {
  name = "dz-ytmdl";
  src = ./.;
  packageJSON = ./package.json;
  yarnLock = ./yarn.lock;
  yarnNix = ./yarn.nix;
}
