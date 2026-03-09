{
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = ["com.mitchellh.ghostty.desktop"];
    };
  };

  xdg.mime = {
    enable = true;
    defaultApplications = {
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
    };
  };
  xdg.menus.enable = true;
}
