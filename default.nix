let
  sources = import ./+npins;

  nixpkgs = import sources.nixpkgs {};
  utils = import ./lib;
  inputs = import ./inputs.nix;
  evalMod = (import "${sources.nixpkgs}/nixos/lib" {}).evalModules;

  self =
    (evalMod {
      modules = [
        {
          modules.nixos.nix = {
            nix.settings.plugin-files = "${nixpkgs.callPackage ./lib/extraBuiltins {}}/lib/nix/plugins";
          };
        }
        {
          imports = utils.recursiveImport {
            dirs = [./modules ./options];
            excludePrefixedWith = ["_" "+"];
          };
        }
      ];
      specialArgs = {
        inherit self utils inputs;
        pkgs = nixpkgs;
      };
    }).config;
in
  self
