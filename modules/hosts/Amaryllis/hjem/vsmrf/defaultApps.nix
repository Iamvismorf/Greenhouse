{
  modules.hjem.vsmrf = {
    xdg.menus.enable = true;

    hjem.users.vsmrf = {
      xdg.config.files = {
        "xdg-terminals.list".text = "com.mitchellh.ghostty.desktop";
      };
      xdg.mime-apps.default-applications = {
        "application/xml" = ["nvim.desktop"];
        "text/plain" = ["nvim.desktop"];
        "text/x-csrc" = ["nvim.desktop"];

        "image/png" = ["viewnior.desktop"];
        "image/jpg" = ["viewnior.desktop"];
        "image/webp" = ["viewnior.desktop"];
        "image/svg+xml" = ["viewnior.desktop"];
        "image/jpeg" = ["viewnior.desktop"];

        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
        "x-scheme-handler/about" = ["firefox.desktop"];
        "x-scheme-handler/unknown" = ["firefox.desktop"];

        "inode/directory" = ["org.kde.dolphin.desktop"];
      };
    };
  };
}
