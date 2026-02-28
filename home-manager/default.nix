attrs: ({ mk-home-manager = ((import ./home.nix) attrs); } // (
    attrs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = attrs.nixpkgs.legacyPackages.${system};
        zn = attrs.zn-nix.mk-zn system;
      in {
        packages.default = pkgs.callPackage ./home-manager/dz-hm/default.nix;
      })))
