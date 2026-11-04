{
  modules.hjem.vix = {
    xdg.menus.enable = true;

    /*
            todo: append in kdeglobals for dolphin
          [General]
    TerminalService=com.mitchellh.ghostty.desktop
    TerminalApplication=ghostty
    */

    hjem.users.vix = {
      xdg.config.files = {
        # "xdg-terminals.list".text = "com.mitchellh.ghostty.desktop";
        #todo: doesn't work
        "xdg-terminals.list".text = "Alacritty.desktop";
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

        # "text/html" = "firefox.desktop";
        "application/pdf" = "firefox.desktop";
        "application/html" = "firefox.desktop";
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
        "x-scheme-handler/about" = ["firefox.desktop"];
        "x-scheme-handler/unknown" = ["firefox.desktop"];

        "inode/directory" = ["org.kde.dolphin.desktop"];
      };
    };
  };
}
