let
  # sources = import ./+npins;
  #
  # pkgs = import sources.nixpkgs {};
  # utils = import ./lib;
  # inputs = import ./inputs.nix;
  # evalMod = (import "${sources.nixpkgs}/nixos/lib" {}).evalModules;
  # self =
  #   (evalMod {
  #     modules = [
  #       {
  #         imports = builtins.listNixFilesRecursive {
  #           dirs = [./modules ./options];
  #           excludePrefixedWith = ["_" "+"];
  #         };
  #       }
  #     ];
  #
  #     specialArgs = {
  #       inherit self utils inputs sources pkgs;
  #     };
  #   }).config;
  self = (import ./evaledConfig.nix).config;
in
  self
