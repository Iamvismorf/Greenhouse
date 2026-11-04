#todo: some of the nixos/ is cursed
let
  self = (import ./evaledConfig.nix).config;
in
  self
