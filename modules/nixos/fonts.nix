{
  modules.nixos.fonts = {pkgs, ...}: {
    fonts.fontDir.enable = true;
    fonts.enableDefaultPackages = true;
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = ["Atkinson Hyperlegible Next Medium"];
          sansSerif = ["Atkinson Hyperlegible Next Medium"];
          monospace = ["Atkinson Hyperlegible Next Medium"];
        };
      };
    };

    fonts.packages = [
      pkgs.nerd-fonts.commit-mono
      pkgs.nerd-fonts.symbols-only
      pkgs.atkinson-hyperlegible-next
      pkgs.font-awesome
    ];
  };
}
