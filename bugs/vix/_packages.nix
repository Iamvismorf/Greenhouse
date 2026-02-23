#todo: categorize packages
{
  pkgs,
  sources,
  ...
}: let
  vixvim = (import sources.mnw).lib.wrap {inherit pkgs sources;} ./_config/neovim;
in
  builtins.attrValues {
    inherit
      (pkgs)
      #theme
      swww
      waypaper
      #terminal
      waybar
      ghostty
      bottom
      eza
      jq
      fd
      bat
      ouch
      tree
      ripgrep
      fzf
      git
      wtype
      socat
      fastfetch
      yazi
      resvg
      # gui
      viewnior
      mpv
      firefox
      fuzzel
      #screenshot
      hyprshot
      ;
    inherit
      (pkgs.kdePackages)
      dolphin
      ark
      qtsvg
      breeze
      ;
  }
  ++ [
    (pkgs.vesktop.overrideAttrs (oldAttrs: {
      desktopItems =
        map (
          item:
            item.override {icon = "discord";}
        )
        oldAttrs.desktopItems;
    }))

    vixvim.devMode
  ]
