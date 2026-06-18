{
  pkgs,
  inputs,
}: let
  mnw = inputs.mnw.lib.wrap {inherit pkgs inputs;} ./_config/neovim;
  yazi = pkgs.callPackage ./_config/yazi {inherit inputs;};
in
  builtins.attrValues {
    inherit (pkgs) awww waypaper;
    inherit (pkgs) inkscape firefox fuzzel swappy viewnior libreoffice git;
    inherit (pkgs) btop bottom sysstat eza tree fastfetch bat zoxide hyprshot;
    inherit (pkgs) gpu-screen-recorder-gtk wf-recorder yt-dlp jq fd ripgrep fzf ouch;
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

    # (inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.override (_: {
    #   withI3 = false;
    #   withX11 = false;
    # }))

    (pkgs.callPackage (import inputs.quickshell) {
      withI3 = false;
      withX11 = false;
    })

    inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default

    (pkgs.vesktop.overrideAttrs (oldAttrs: {
      desktopItems =
        map (
          item:
            item.override {icon = "discord";}
        )
        oldAttrs.desktopItems;
    }))

    mnw.devMode
    yazi
  ]
