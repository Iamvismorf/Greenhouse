let
  sources = import ../npins;

  # pkgs =
  #   import
  #   (myLib.flakeToNix {
  #     src = sources.nixpkgs;
  #     copySourceTreeToStore = false;
  #   }).defaultNix {config.allowUnfree = true;};

  pkgs = import sources.nixpkgs {
    config.allowUnfree = true;
  };

  myLib = import ../myLib;
  nixosSystem = import "${sources.nixpkgs}/nixos/lib/eval-config.nix";

  hjem = import sources.hjem {};

  mkHost = hostname:
    nixosSystem {
      specialArgs = {
        inherit sources pkgs myLib;
      };
      modules = [
        ./${hostname}/configuration.nix
        ./nixosModules
        hjem.nixosModules.default
        ../bugs
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
