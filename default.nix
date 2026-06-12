let
  sources = import ./+tack;

  nixpkgs = import sources.nixpkgs {};
  utils = import ./lib;

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
        inherit self utils;
        inputs = sources;
        pkgs = nixpkgs;
      };
    }).config;
in
  self
