{
  description = "Home Manager configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:nix-community/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
    zn-nix.url = "github:mitchdzugan/zn.nix";
    zn-nix.inputs.nixpkgs.follows = "nixpkgs";
    ztr.url = "github:mitchdzugan/ztr";
    ztr.inputs.nixpkgs.follows = "nixpkgs";
    zkg.url = "github:mitchdzugan/zkg";
    zkg.inputs.nixpkgs.follows = "nixpkgs";
    zkm.url = "github:mitchdzugan/zkm";
    zkm.inputs.nixpkgs.follows = "nixpkgs";
    slippi.url = "github:lytedev/slippi-nix";
    slippi.inputs.nixpkgs.follows = "nixpkgs";
    yt-upload-playwright.url = "github:mitchdzugan/yt_upload_playwright";
    yt-upload-playwright.inputs.nixpkgs.follows = "nixpkgs";
    slp-rec.url = "github:mitchdzugan/slp-rec";
    slp-rec.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: (
    let
      utils = (import ./utils) inputs;
      inputs-utils = inputs // { utils = utils; };
      __ = (import ./__) inputs-utils;
      inputs-utils-__ = inputs-utils // { __ = __; };
      neovim = (import ./neovim) inputs-utils-__;
      inputs-utils-neovim =inputs-utils // { neovim = neovim; };
      free-dom = (import ./free-dom) inputs-utils-__;
      home-manager = (import ./home-manager) inputs-utils-neovim;
    in home-manager // { __ = __; utils = utils; free-dom = free-dom; } // (
      inputs.flake-utils.lib.eachDefaultSystem (system: (
        let pkgs = inputs.nixpkgs.legacyPackages.${system}; in {
          devShells.default = __.mkDevShell pkgs;
          devShells.neovim = neovim.mkDevShell pkgs;
          devShells."__" = __.mkDevShell pkgs;
          devShells."free-dom" = free-dom.mkDevShell pkgs;
          devShells."home-manager" = neovim.mkDevShell pkgs;
        }
      ))
    )
  );
}
