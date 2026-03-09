{
  modules.hjem.theming = {
    pkgs,
    lib,
    config,
    ...
  }: let
    inherit (lib) mkOption mkIf;
    inherit (lib.types) package nullOr bool str ints oneOf path int listOf;
    cfg = config.theming;
    mkFontOption = {
      family = mkOption {
        type = nullOr str;
        default = "Atkinson Hyperlegible Next Medium";
      };
      size = mkOption {
        type = nullOr int;
        default = 11;
      };
      weight = mkOption {
        type = nullOr int;
        default = -1;
      };
    };
  in {
    options.theming = {
      enable = mkOption {
        type = nullOr bool;
        default = false;
      };
      username = mkOption {
        type = str;
        default = "";
      };

      gtk = {
        package = mkOption {
          type = nullOr package;
          default = pkgs.adw-gtk3;
        };
        name = mkOption {
          type = nullOr str;
          default = "adw-gtk3-dark";
        };
      };
      cursor = {
        package = mkOption {
          type = nullOr package;
          default = pkgs.kdePackages.breeze;
        };
        name = mkOption {
          type = nullOr str;
          default = "Breeze_Light";
        };
        size = mkOption {
          type = nullOr ints.u8;
          default = 24;
        };
      };
      iconTheme = {
        package = mkOption {
          type = nullOr package;
          default = pkgs.papirus-icon-theme;
        };
        name = mkOption {
          type = nullOr str;
          default = "Papirus-Dark";
        };
      };

      qt = {
        packages = mkOption {
          type = nullOr (listOf package);
          default = [pkgs.kdePackages.breeze pkgs.kdePackages.breeze-icons];
        };
        colorScheme = mkOption {
          type = oneOf [path str];
          default = "";
        };
        iconTheme = mkOption {
          type = nullOr str;
          default = "breeze-dark";
        };
        style = mkOption {
          type = nullOr str;
          default = "breeze";
        };
        font = mkFontOption;
        fontFixed = mkFontOption;
      };
    };
    config = mkIf cfg.enable {
      assertions = [
        {
          assertion = !(cfg.enable && cfg.username == "");
          message = "this is scuffed but username must be manually set";
        }
      ];
      hjem.users.${cfg.username} = {
        programs.qtengine = {
          enable = true;
          config = {
            theme = {
              colorScheme = cfg.qt.colorScheme;
              iconTheme = cfg.qt.iconTheme;
              style = cfg.qt.style;

              font = {
                family = cfg.qt.font.family;
                size = cfg.qt.font.size;
                weight = cfg.qt.font.weight;
              };

              fontFixed = {
                family = cfg.qt.fontFixed.family;
                size = cfg.qt.fontFixed.size;
                weight = cfg.qt.fontFixed.weight;
              };
            };
            misc.singleClickActivate = false;
          };
        };
        xdg.data.files = {
          "icons/${cfg.cursor.name}".source = "${cfg.cursor.package}/share/icons/${cfg.cursor.name}";
          "icons/default/index.theme".text = ''
            [Icon Theme]
            Name=Default
            Inherits=${cfg.cursor.name}
          '';
        };

        xdg.config.files."environment.d/envvars.conf".text = ''
          XCURSOR_SIZE=${toString cfg.cursor.size}
          XCURSOR_THEME=${cfg.cursor.name}
          HYPRCURSOR_SIZE=${toString cfg.cursor.size}
          HYPRCURSOR_THEME=${cfg.cursor.name}
          QT_QPA_PLATFORMTHEME=qtengine
          DCONF_PROFILE=${cfg.username}
        '';

        packages =
          [
            cfg.gtk.package
            cfg.iconTheme.package
          ]
          ++ cfg.qt.packages;
      };
      programs.dconf.profiles.${cfg.username}.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              cursor-theme = cfg.cursor.name;
              cursor-size = lib.gvariant.mkUint32 cfg.cursor.size;

              gtk-theme = cfg.gtk.name;
              color-scheme = "prefer-dark";

              icon-theme = cfg.iconTheme.name;
              font-name = "${cfg.qt.font.family} ${toString cfg.qt.font.size}";
              #accentcolor
            };
          };
        }
      ];
    };
  };
}
