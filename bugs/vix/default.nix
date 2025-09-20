{
  fl-compat,
  sources,
  pkgs,
  config,
  options,
  lib,
  ...
}: let
  username = "vix";
in {
  options = {
    vix.enable = lib.mkEnableOption "user vix";
  };
  config = lib.mkIf config.vix.enable {
    # "user" font
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = ["Atkinson Hyperlegible Next"];
          sansSerif = ["Atkinson Hyperlegible Next"];
          monospace = ["Atkinson Hyperlegible Next"];
        };
      };
    };

    fonts.packages = [
      pkgs.nerd-fonts.commit-mono

      pkgs.nerd-fonts.symbols-only
      pkgs.atkinson-hyperlegible-next
      pkgs.material-symbols
      pkgs.font-awesome
    ];
    # environment.systemPackages = [
    #   pkgs.papirus-icon-theme
    #   pkgs.adw-gtk3
    # ];
    programs.dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            cursor-theme = "Breeze_light";
            gtk-theme = "adw-gtk3-dark";
            icon-theme = "Papirus-Dark";
            color-scheme = "prefer-dark";
          };
        };
      }
    ];

    users.users.${username} = {
      isNormalUser = true;
      packages = [
        pkgs.papirus-icon-theme
        pkgs.adw-gtk3
      ];
      extraGroups = [
        "networkmanager"
        "input"
        "wheel"
      ];
      shell = pkgs.fish;
    };
    programs.fish.enable = true;
    hjem.linker = pkgs.smfh;
    hjem.users.${username} = {
      clobberFiles = true;
      files = {
        ".gtkrc-2.0".source = ./config/gtk/.gtkrc-2.0;
        ".icons/default".source = "${pkgs.kdePackages.breeze}/share/icons/Breeze_Light";
      };
      xdg.config.files = {
        "fuzzel/fuzzel.ini".source = ./config/fuzzel/fuzzel.ini;
        "gtk-3.0/settings.ini".source = ./config/gtk/gtk3/settings.ini;
        "gtk-4.0/settings.ini".source = ./config/gtk/gtk4/settings.ini;
        "ghostty".source = ./config/ghostty;
        "fastfetch".source = ./config/fastfetch;
        "git".source = ./config/git;
        # "yazi".source = ./config/yazi;
        "yazi/flavors".source = ./config/yazi/flavors;
        "yazi/init.lua".source = ./config/yazi/init.lua;
        "yazi/plugins/relative-motions.yazi".source = pkgs.yaziPlugins.relative-motions;
        "yazi/plugins/ouch.yazi".source = pkgs.yaziPlugins.ouch;
        "yazi/keymap.toml".source = ./config/yazi/keymap.toml;
        "yazi/theme.toml".source = ./config/yazi/theme.toml;
        "yazi/yazi.toml".source = ./config/yazi/yazi.toml;
        "yazi/plugins/git.yazi".source = pkgs.yaziPlugins.git;
        "fish/config.fish".source = ./config/fish/config.fish;
        "fish/functions".source = ./config/fish/functions;
      };
      packages = import ./packages.nix {inherit sources pkgs;};
    };
  };
}
