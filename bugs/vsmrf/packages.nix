#TODO: categorize packages
{
  pkgs,
  sources,
  myLib,
  ...
}: let
  ghostty = import sources.ghostty;
  vixvim = (import sources.mnw).lib.wrap {inherit pkgs sources;} ./config/neovim;
  quickshell = import sources.quickshell;
  hyprland = (myLib.flakeToNix {src = sources.hyprland;}).defaultNix;
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
      # ghostty
      resvg
      # gui
      firefox
      viewnior
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
    # (
    #   hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland.override
    #   {
    #     debug = true;
    #   }
    # )
    (pkgs.mpv.override {
      scripts = [
        pkgs.mpvScripts.mpris
      ];
    })
    (pkgs.wrapOBS {
      plugins = [pkgs.obs-studio-plugins.obs-pipewire-audio-capture];
    })
    (pkgs.callPackage quickshell {
      withI3 = false;
      withX11 = false;
    })
    # ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default.override
    ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default #use this
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
