{
  sources,
  utils,
  ...
}: let
  hjemOut = import sources.hjem {};
  qtengineOut = (utils.flakeToNix {src = sources.qtengine;}).defaultNix;
  # hjemFlake = (utils.flakeToNix {src = sources.hjem;}).defaultNix;
in {
  modules.hjem._ = {pkgs, ...}: {
    imports = [hjemOut.nixosModules.default];

    hjem = {
      linker = hjemOut.packages.smfh;
      # linker = hjemFlake.packages.${pkgs.stdenv.hostPlatform.system}.smfh;

      extraModules = [
        qtengineOut.hjemModules.default
      ];
    };
  };
}
