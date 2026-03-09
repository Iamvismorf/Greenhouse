{
  pkgs,
  yazi,
  ...
}:
yazi.override {
  plugins = {
    inherit (pkgs.yaziPlugins) git ouch relative-motions;
  };
  initLua = ./init.lua;
  flavors = {
    zen_dark = ./flavors/zen_dark.yazi;
  };

  settings.keymap = builtins.readFile ./keymap.toml |> fromTOML;
  settings.theme = builtins.readFile ./theme.toml |> fromTOML;
  settings.yazi = builtins.readFile ./yazi.toml |> fromTOML;
}
