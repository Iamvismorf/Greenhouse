{
  sources,
  pkgs,
  config,
  lib,
  myLib,
  osConfig,
  ...
}: let
  username = "vsmrf";
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
        "video"
        "render"
      ];
      shell = pkgs.fish;
    };
    programs.fish.enable = true;
    hjem.users.${username} = {
      programs.qtengine = {
        enable = true;

        config = {
          theme = {
            # colorScheme = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
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
          misc.singleClickActivate = false;
        };
      };
      clobberFiles = true;
      xdg.config.files = {
        "fuzzel/fuzzel.ini".source = ./_config/fuzzel/fuzzel.ini;
        "nixpkgs".source = ./_config/nixpkgs;
        "mpv/mpv.conf".source = ./_config/mpv/mpv.conf;
        "ghostty".source = ./_config/ghostty;
        "fastfetch".source = ./_config/fastfetch;
        "git".source = ./_config/git;
        "yazi/flavors".source = ./_config/yazi/flavors;
        "yazi/init.lua".source = ./_config/yazi/init.lua;
        "yazi/plugins/relative-motions.yazi".source = pkgs.yaziPlugins.relative-motions;
        "yazi/plugins/ouch.yazi".source = pkgs.yaziPlugins.ouch;
        "yazi/keymap.toml".source = ./_config/yazi/keymap.toml;
        "yazi/theme.toml".source = ./_config/yazi/theme.toml;
        "yazi/yazi.toml".source = ./_config/yazi/yazi.toml;
        "yazi/plugins/git.yazi".source = pkgs.yaziPlugins.git;
        "fish/config.fish".source = ./_config/fish/config.fish;
        "fish/functions".source = ./_config/fish/functions;
        "swappy/config".source = ./_config/swappy/config;
      };
      packages = (import ./_packages.nix {inherit sources pkgs myLib;}) ++ [pkgs.kdePackages.breeze pkgs.kdePackages.breeze-icons];
    };
  };
}
