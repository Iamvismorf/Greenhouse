{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.services.displayManager;
  installedSessions =
    pkgs.runCommand "desktops"
    {
      # trivial derivation
      preferLocalBuild = true;
      allowSubstitutes = false;
    }
    ''
      mkdir -p "$out/share/"{xsessions,wayland-sessions}

      ${lib.concatMapStrings (pkg: ''
          for n in ${lib.concatStringsSep " " pkg.providedSessions}; do
            if ! test -f ${pkg}/share/wayland-sessions/$n.desktop -o \
                      -f ${pkg}/share/xsessions/$n.desktop; then
              echo "Couldn't find provided session name, $n.desktop, in session package ${pkg.name}:"
              echo "  ${pkg}"
              return 1
            fi
          done

          if test -d ${pkg}/share/xsessions; then
            ${pkgs.buildPackages.lndir}/bin/lndir ${pkg}/share/xsessions $out/share/xsessions
          fi
          if test -d ${pkg}/share/wayland-sessions; then
            ${pkgs.buildPackages.lndir}/bin/lndir ${pkg}/share/wayland-sessions $out/share/wayland-sessions
          fi
        '')
        cfg.sessionPackages}
    '';
in {
  # services.displayManager.enable = true;
  environment.sessionVariables.XDG_DATA_DIRS = lib.mkIf (cfg.sessionPackages != []) [
    "${installedSessions}/share"
  ];
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = lib.mkIf config.hyprland.enable {
        prettyName = "Landhypr";
        # binPath = "/run/current-system/sw/bin/Hyprland";
        binPath = lib.mkForce "/run/current-system/sw/bin/start-hyprland";
      };
    };
  };
}
