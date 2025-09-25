{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) types mkOption mkIf;
  cfg = config.theme;

  defaultGtkPkg = pkgs.adw-gtk3;
  defaultCursorPkg = pkgs.kdePackages.breeze;
  defaultIconsPkg = pkgs.papirus-icon-theme;
in {
  options.theme = {
    for = mkOption {
      type = types.str;
    };
    gtk = {
      package = mkOption {
        type = types.package;
        default = defaultGtkPkg;
      };
      name = mkOption {
        type = types.str;
        default =
          if cfg.gtk.package == defaultGtkPkg
          then "adw-gtk3-dark"
          else null;
      };
    };
    cursor = {
      package = mkOption {
        type = types.package;
        default = defaultCursorPkg;
      };
      name = mkOption {
        type = types.str;
        default =
          if cfg.cursor.package == defaultCursorPkg
          then "Breeze_Light"
          else null;
      };
    };
    icons = {
      package = mkOption {
        type = types.package;
        default = defaultIconsPkg;
      };
      name = mkOption {
        type = types.str;
        default =
          if cfg.icons.package == defaultIconsPkg
          then "Papirus-Dark"
          else null;
      };
    };
  };

  config = mkIf config.${cfg.for}.enable {
    hjem.users.${cfg.for} = {
      files = {
        # alternatively override with mkForce in main
        ".icons/default".source = "${cfg.cursor.package}/share/icons/${cfg.cursor.name}";
      };

      packages = [
        cfg.icons.package
        cfg.gtk.package
      ];
    };
    # don't forget to set dconf_profile
    programs.dconf.profiles.${cfg.for}.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            cursor-theme = "${cfg.cursor.name}";
            gtk-theme = "${cfg.gtk.name}";
            icon-theme = "${cfg.icons.name}";
            color-scheme = "prefer-dark";
          };
        };
      }
    ];
  };
}
