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
  imports = [
    ../theme.nix
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
    hjem.users.${username} = {
      clobberFiles = true;
      xdg.config.files = {
        "fuzzel/fuzzel.ini".source = ./config/fuzzel/fuzzel.ini;
        "ghostty".source = ./config/ghostty;
        "fastfetch".source = ./config/fastfetch;
        "git".source = ./config/git;
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
        "uwsm/env".source = ./config/uwsm/env;
      };
      packages = import ./packages.nix {inherit sources pkgs;};
    };
  };
}
