{lib, ...}: {
  options.nC = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
    description = "nixos configuration similar to flake's nixosConfigurations";
  };
}
