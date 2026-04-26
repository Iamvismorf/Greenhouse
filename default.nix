let
  sources = import ./+npins;

  nixpkgs = import sources.nixpkgs {};
  utils = import ./utils;
  inputs = import ./inputs.nix;

  modules = {
    imports = utils.recursiveImport {
      dirs = [./modules ./options];
      excludePrefixedWith = ["_" "+"];
    };
  };

  self =
    (nixpkgs.lib.evalModules {
      modules = [modules];
      specialArgs = {
        inherit self utils inputs;
        pkgs = nixpkgs;
      };
    }).config;
in
  self
