let
  sources = import ../npins;
  pkgs = import sources.nixpkgs {
    config.allowUnfree = true;
  };
  fl-compat = import sources.flake-compat;
  myLib = import ../myLib;
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";

  hjem =
    (fl-compat {
      src = sources.hjem;
    }).defaultNix;

  mkHost = hostname:
    nixosSystem {
      specialArgs = {
        inherit sources pkgs fl-compat myLib;
      };
      modules = [
        ./${hostname}/configuration.nix
        ./nixosModules
        hjem.nixosModules.default
        ../bugs
        # {
        #   config.nixpkgs.pkgs = pkgs;
        # }
        {
          nix.channel.enable = false;
          nix.nixPath = ["nixpkgs=/etc/nixos/nixpkgs"];

          environment.etc = {
            "nixos/nixpkgs".source = builtins.storePath pkgs.path;
          };
        }
      ];
    };
  hosts = ["Daffodil" "Amaryllis"];
in
  myLib.genAttrs hosts mkHost
