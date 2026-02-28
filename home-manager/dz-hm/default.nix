{ pkgs, ... }: pkgs.mkYarnPackage {
  name = "dz-hm";
  src = ./.;
  packageJSON = ./package.json;
  yarnLock = ./yarn.lock;
  yarnNix = ./yarn.nix;
}
