{
  pkgs,
  sources,
  utils,
  ...
}: let
  # ghosttyOut = import sources.ghostty;
  ghosttyOut = (utils.flakeToNix {src = sources.ghostty;}).defaultNix;
  quickshellOut = import sources.quickshell;

  vixvim = (import sources.mnw).lib.wrap {inherit pkgs sources;} ./_config/neovim;
  yazi = pkgs.callPackage ./_config/yazi {};
in
  builtins.attrValues {
    inherit (pkgs) swww waypaper;
    inherit (pkgs) inkscape firefox fuzzel swappy viewnior libreoffice git;
    inherit (pkgs) btop bottom sysstat eza tree fastfetch bat hyprshot;
    inherit (pkgs) gpu-screen-recorder yt-dlp jq fd ripgrep fzf ouch;
    inherit (pkgs) wtype socat grim slurp imagemagick resvg;

    inherit (pkgs.kdePackages) dolphin ark breeze qtsvg;
  }
  ++ [
    (pkgs.mpv.override {
      scripts = [
        pkgs.mpvScripts.mpris
      ];
    })
    (pkgs.wrapOBS {
      plugins = [pkgs.obs-studio-plugins.obs-pipewire-audio-capture];
    })
    (pkgs.callPackage quickshellOut {
      withI3 = false;
      withX11 = false;
    })
    # ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default.override
    ghosttyOut.packages.${pkgs.stdenv.hostPlatform.system}.default #use this
    # (pkgs.callPackage (ghostty + "/nix/package.nix") {
    #   optimize = "ReleaseFast";
    #   # revision = sources.ghostty.revision;
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
    yazi
  ]
