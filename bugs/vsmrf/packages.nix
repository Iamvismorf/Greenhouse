#todo: obs
#categorize packages
{
  pkgs,
  sources,
  ...
}: let
  ghostty = import sources.ghostty;
  vixvim = (import sources.mnw).lib.wrap pkgs ./config/neovim;
  quickshell = import sources.quickshell;
in
  builtins.attrValues {
    inherit
      (pkgs)
      #theme
      material-symbols
      swww
      waypaper
      #terminal
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
    (pkgs.callPackage quickshell {
      withI3 = false;
      withX11 = false;
    })
    (pkgs.callPackage (ghostty + "/nix/package.nix") {
      optimize = "ReleaseFast";
      revision = sources.ghostty.revision;
    })
    (pkgs.equibop.overrideAttrs (oldAttrs: {
      desktopItems = oldAttrs.desktopItems.override {icon = "discord";};
    }))
    # vixvim
    vixvim.devMode
  ]
