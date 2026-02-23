#todo: categorize packages
{
  pkgs,
  sources,
  ...
}: let
  vixvim = (import sources.mnw).lib.wrap {inherit pkgs sources;} ./config/neovim;
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
    # (pkgs.callPackage (ghostty + "/nix/package.nix") {
    #   optimize = "ReleaseFast";
    #   revision = sources.ghostty.revision;
    # })

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
