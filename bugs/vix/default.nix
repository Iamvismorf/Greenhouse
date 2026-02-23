{
  sources,
  pkgs,
  config,
  lib,
  myLib,
  ...
}: let
  username = "vix";
in {
  imports = [
    ../_theme.nix
  ];

  options = {
    ${username}.enable = lib.mkEnableOption "user ${username}";
  };
  config = lib.mkIf config.${username}.enable {
    theme = {
      for = username;
    };

    users.users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "input"
        "wheel"
      ];
      shell = pkgs.fish;
    };

    programs.fish.enable = true;
    #todo: move to theme
    hjem.users.${username} = {
      programs.qtengine = {
        enable = true;

        config = {
          theme = {
            colorScheme = ./_config/BreezeDark.colors;
            iconTheme = "breeze-dark";
            style = "breeze";

            font = {
              family = "Atkinson Hyperlegible Next Medium";
              size = 11;
              weight = -1;
            };

            fontFixed = {
              family = "Atkinson Hyperlegible Next Medium";
              size = 11;
              weight = -1;
            };
          };

          misc = {
            singleClickActivate = false;
            menusHaveIcons = true;
            shortcutsForContextMenus = true;
          };
        };
      };

      clobberFiles = true;
      xdg.config.files = {
        "waybar".source = ./_config/waybar;
        "fastfetch".source = ./_config/fastfetch;
        "yazi/flavors".source = ./_config/yazi/flavors;
        "yazi/init.lua".source = ./_config/yazi/init.lua;
        "yazi/plugins/relative-motions.yazi".source = pkgs.yaziPlugins.relative-motions;
        "yazi/plugins/ouch.yazi".source = pkgs.yaziPlugins.ouch;
        "yazi/keymap.toml".source = ./_config/yazi/keymap.toml;
        "yazi/theme.toml".source = ./_config/yazi/theme.toml;
        "yazi/yazi.toml".source = ./_config/yazi/yazi.toml;
        "yazi/plugins/git.yazi".source = pkgs.yaziPlugins.git;

        "fuzzel/fuzzel.ini".source = ../vsmrf/_config/fuzzel/fuzzel.ini;
        "fish/config.fish".source = ../vsmrf/_config/fish/config.fish;
        "ghostty".source = ../vsmrf/_config/ghostty;
        "git".source = ../vsmrf/_config/git;
        "fish/functions".source = ../vsmrf/_config/fish/functions;
      };
      packages = (import ./_packages.nix {inherit sources pkgs myLib;}) ++ [pkgs.kdePackages.breeze pkgs.kdePackages.breeze-icons];
    };
  };
}
