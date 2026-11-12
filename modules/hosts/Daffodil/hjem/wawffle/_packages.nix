{
  pkgs,
  inputs,
  config,
}: let
  mnw = inputs.mnw.lib.wrap {inherit pkgs inputs;} config.hjem.metadata.vsmrf.neovim.defaultNix;
  yazi = pkgs.callPackage config.hjem.metadata.vsmrf.yazi.defaultNix {inherit inputs;};
in
  builtins.attrValues {
    inherit (pkgs) awww waypaper waybar;
    inherit (pkgs) ghostty viewnior mpv firefox fuzzel git libreoffice foliate;
    inherit (pkgs) bottom fastfetch eza bat tree;
    inherit (pkgs) zoxide jq fd fzf ripgrep ouch wtype socat resvg hyprshot;

    inherit (pkgs.kdePackages) dolphin ark qtsvg breeze kio kio-admin;
  }
  ++ [
    (pkgs.equibop.overrideAttrs (o: {
      desktopItems = o.desktopItems.override {
        icon = "discord";
        desktopName = "Discord";
      };
    }))

    mnw.devMode
    # inputs.nvim-flakey.packages.${pkgs.stdenv.hostPlatform.system}.default
    yazi
  ]
