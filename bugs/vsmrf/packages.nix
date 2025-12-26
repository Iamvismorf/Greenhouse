#TODO: categorize packages
{
  pkgs,
  sources,
  ...
}: let
  ghostty = import sources.ghostty;
  vixvim = (import sources.mnw).lib.wrap {inherit pkgs sources;} ./config/neovim;
  quickshell = import sources.quickshell;
in
  builtins.attrValues {
    inherit
      (pkgs)
      #theme
      inkscape
      swww
      waypaper
      #terminal
      yt-dlp
      bottom
      btop
      sysstat
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
      obs-studio
      firefox
      viewnior
      mpv
      fuzzel
      libreoffice
      #screenshot
      hyprshot
      ;
    inherit
      (pkgs.kdePackages)
      dolphin
      ark
      breeze
      ;
  }
  ++ [
    (pkgs.callPackage quickshell {
      withI3 = false;
      withX11 = false;
    })
    # ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default.override
    ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default
    # (pkgs.callPackage (ghostty + "/nix/package.nix") {
    #   optimize = "ReleaseFast";
    #   # revision = sources.ghostty.revision;
    # })
    (pkgs.equibop.overrideAttrs (oldAttrs: {
      desktopItems = oldAttrs.desktopItems.override {icon = "discord";};
    }))
    (pkgs.callPackage ../../pkgs/derivation.nix {})
    # vixvim
    vixvim.devMode
  ]
