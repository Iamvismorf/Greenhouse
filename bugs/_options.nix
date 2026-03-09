{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) package nullOr bool str ints oneOf path int listOf;
  cfg = config.theming;
in {
  options.theming = {
    enable = mkOption {
      type = bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    programs.waybar.enable = true;
  };
}
