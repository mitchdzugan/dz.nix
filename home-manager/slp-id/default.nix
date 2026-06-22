{ pkgs, ... }: pkgs.buildNpmPackage {
  pname = "slp-id";
  version = "1.0.0";
  src = ./.;
  npmDepsHash = "sha256-w0UA5WsyfmyhRzPNjUEJb/DlTJ1pNCwP9DrpQujpr+s=";
  npmDepsFetcherVersion = 2;
  makeCacheWritable = true;
  npmFlags = [ "--legacy-peer-deps" ];
}
