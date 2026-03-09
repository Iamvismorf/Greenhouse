#todo: implement this
{
  self,
  sources,
  utils,
  ...
}: {
  modules.wm.niri = {
    lib,
    pkgs,
    config,
    ...
  }: let
    niriOut = (utils.flakeToNix {src = sources.niri;}).defaultNix;
  in {
    imports = [self.modules.wm._];

    options = {
      wm.niri.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      wm.niri.buildFromSrc = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };

    config = (lib.mkIf config.wm.niri.enable) {
      programs.niri =
        {
          enable = true;
          useNautilus = false;
        }
        // lib.optionalAttrs (config.wm.niri.enable) {
          package = niriOut.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };

      environment.systemPackages = [
        pkgs.fuzzel
        pkgs.alacritty
      ];
    };
  };
}
