let
  sources = import ./+npins;

  nixpkgs = import sources.nixpkgs {};
  utils = import ./utils;

  modules = {
    imports =
      utils.recursiveImport {
        dir = ./modules;
        excludePrefixedWith = ["_" "+"];
      }
      ++ (utils.recursiveImport {
        dir = ./options;
      });
  };

  self =
    (nixpkgs.lib.evalModules {
      modules = [modules];
      specialArgs = {
        inherit self sources utils;
      };
    }).config;
in
  self
