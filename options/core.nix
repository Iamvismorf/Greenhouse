# credit: github.com/vic/dendritic-unflake
{lib, ...}: {
  options.modules = lib.mkOption {
    description = "<class>.<aspect> modules. akin to flake-parts' flake.modules";
    type = lib.types.lazyAttrsOf (lib.types.lazyAttrsOf lib.types.deferredModule);
    default = {};
  };

  options.nC = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
  };
}
