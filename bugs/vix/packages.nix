#todo: categorize packages
{
  pkgs,
  sources,
  ...
}: let
  # ghostty = import sources.ghostty;
  vixvim = (import sources.mnw).lib.wrap pkgs ./config/neovim;
  quickshell = import sources.quickshell;
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
      peaclock
      bottom
      eza
      jq
      fd
      obs-studio
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
    (pkgs.callPackage quickshell {
      withI3 = false;
      withX11 = false;
    })

    (pkgs.equibop.overrideAttrs (oldAttrs: {
      desktopItems = oldAttrs.desktopItems.override {icon = "discord";};
    }))
    # vixvim
    vixvim.devMode
  ]
