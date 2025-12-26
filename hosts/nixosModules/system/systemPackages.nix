{pkgs, ...}: {
  environment.systemPackages = builtins.attrValues {
    inherit
      (pkgs)
      tree
      git
      yazi
      neovim
      firefox
      kitty
      nh
      wl-clipboard
      cliphist
      brightnessctl
      libnotify
      npins
      grim
      slurp
      swappy
      imagemagick
      # direnv
      ;
  };
}
