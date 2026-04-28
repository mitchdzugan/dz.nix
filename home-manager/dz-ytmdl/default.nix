{ pkgs, ... }: pkgs.buildNpmPackage {
  pname = "dz-ytmdl";
  version = "1.0.0";
  src = ./.;
  npmDepsHash = "sha256-PmmaYZ3VNQiOYfaH9aHYRmbRNdU9S3CsKdFR+b9k0aA=";
}
