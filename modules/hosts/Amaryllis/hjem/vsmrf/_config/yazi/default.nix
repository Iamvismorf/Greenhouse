#todo: yazi undo
{
  pkgs,
  yazi,
  inputs,
  ...
}:
yazi.override {
  plugins = {
    inherit (pkgs.yaziPlugins) git ouch;
    relative-motions = pkgs.yaziPlugins.relative-motions.overrideAttrs {
      src = inputs.relative-motions-yazi.outPath;
    };
  };
  initLua = ./init.lua;
  flavors = {
    zen_dark = ./flavors/zen_dark.yazi;
  };

  settings.keymap = builtins.readFile ./keymap.toml |> fromTOML;
  settings.theme = builtins.readFile ./theme.toml |> fromTOML;
  settings.yazi = builtins.readFile ./yazi.toml |> fromTOML;
}
