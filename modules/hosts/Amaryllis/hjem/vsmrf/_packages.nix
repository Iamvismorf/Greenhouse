{
  pkgs,
  inputs,
  sources,
}: let
  unflake = (import sources.flake-inputs).import-flake;
  mnw = inputs.mnw.lib.wrap {inherit pkgs inputs;} ./_config/neovim;
  yazi = pkgs.callPackage ./_config/yazi {inherit inputs;};
  vimacs = with pkgs; ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [
    epkgs.evil
    epkgs.evil-collection
    epkgs.evil-terminal-cursor-changer
  ]));
  snippy = unflake {src = sources.snippy;};
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

    (pkgs.callPackage (import inputs.quickshell) {
      withI3 = false;
      withX11 = false;
    })

    pkgs.cinny-desktop
    pkgs.ghostty
    # inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default

    (pkgs.equibop.overrideAttrs (o: {
      desktopItems = o.desktopItems.override {
        icon = "discord";
        desktopName = "Discord";
      };
    }))
    vimacs
    snippy.packages.${pkgs.stdenv.hostPlatform.system}.default

    # (pkgs.vesktop.overrideAttrs (oldAttrs: {
    #   desktopItems =
    #     map (
    #       item:
    #         item.override {icon = "discord";}
    #     )
    #     oldAttrs.desktopItems;
    # }))

    mnw.devMode
    yazi
  ]
