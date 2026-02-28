{ pkgs, ... }: pkgs.mkYarnPackage {
  name = "dz-theme";
  src = ./.;
  packageJSON = ./package.json;
  yarnLock = ./yarn.lock;
  yarnNix = ./yarn.nix;
}
