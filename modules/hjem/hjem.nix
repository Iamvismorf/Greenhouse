{
  inputs,
  utils,
  ...
}: let
in {
  modules.hjem._ = {pkgs, ...}: let
    qtengineOut = utils._flakeToNix {
      src = inputs.qtengine;
      overrides = {
        nixpkgs = pkgs.path; # all qt apps need "follows"
      };
    };
  in {
    imports = [inputs.hjem.nixosModules.default];

    hjem = {
      linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;

      extraModules = [
        qtengineOut.hjemModules.default
      ];
    };
  };
}
