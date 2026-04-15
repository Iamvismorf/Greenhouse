let
  sources = import ./+npins;

  nixpkgs = import sources.nixpkgs {};
  utils = import ./utils;

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
        inherit self sources utils;
        pkgs = nixpkgs;
      };
    }).config;
in
  self
