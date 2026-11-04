# for nixos config we only interested in `self.config`. This file is used in shell.nix to provide nixos options to the nixd lsp
let
  sources = import ./+npins;

  pkgs = import sources.nixpkgs {};
  utils = import ./lib;
  inputs = import ./inputs.nix;
  evalModules = (import "${sources.nixpkgs}/nixos/lib" {}).evalModules;

  self = evalModules {
    modules = [
      {
        imports = utils.recursiveImport {
          dirs = [./modules ./options];
          excludePrefixedWith = ["_" "+"];
        };
      }
    ];

    specialArgs = {
      inherit utils inputs sources pkgs;
      self = self.config;
    };
  };
in
  self
