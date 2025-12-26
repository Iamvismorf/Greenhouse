{
  lib,
  config,
  ...
}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = lib.mkIf config.hyprland.enable {
        prettyName = "Hyprland";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };
}
