#TODO:manual configuring zsh/ using zsh module from hjem-rum
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
    fonts.packages = [
      pkgs.nerd-fonts.commit-mono

      pkgs.nerd-fonts.symbols-only
      pkgs.atkinson-hyperlegible-next
      pkgs.material-symbols
      pkgs.font-awesome
    ];

    users.users.${username} = {
      isNormalUser = true;
      packages = [
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
      };
      xdg.config.files = {
        "ghostty".source = ./config/ghostty;
        "fastfetch".source = ./config/fastfetch;
        "git".source = ./config/git;
        # "fish/config.fish".source = ./config/fish/config.fish;
        # "yazi".source = ./config/yazi;
        "yazi/flavors".source = ./config/yazi/flavors;
        "yazi/init.lua".source = ./config/yazi/init.lua;
        "yazi/plugins/relative-motions.yazi".source = pkgs.yaziPlugins.relative-motions;
        "yazi/keymap.toml".source = ./config/yazi/keymap.toml;
        "yazi/theme.toml".source = ./config/yazi/theme.toml;
        "yazi/yazi.toml".source = ./config/yazi/yazi.toml;
        "starship.toml".source = ./config/starship.toml;
      };
      packages = import ./packages.nix {inherit sources pkgs;};
    };
  };
}
