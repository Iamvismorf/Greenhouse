{
  pkgs,
  config,
  myLib,
  sources,
  lib,
  ...
}: let
  niriOut = (myLib.flakeToNix {src = sources.niri;}).defaultNix;
in {
  options = {
    niri.enable = myLib.mkEnabledByDefault null;
    niri.buildFromFlakes = myLib.mkEnabledByDefault "whether to build niri from source";
  };
  config = lib.mkIf config.niri.enable {
    programs.niri =
      {
        enable = true;
        useNautilus = false;
      }
      // lib.optionalAttrs (config.niri.buildFromFlakes) {
        package = niriOut.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
  };
}
