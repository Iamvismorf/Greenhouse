{
  sources,
  utils,
  ...
}: let
  hjemOut = import sources.hjem {};
  qtengineOut = (utils.flakeToNix {src = sources.qtengine;}).defaultNix;
in {
  modules.hjem._ = {
    imports = [hjemOut.nixosModules.default];

    hjem = {
      linker = hjemOut.packages.smfh;

      extraModules = [
        qtengineOut.hjemModules.default
      ];
    };
  };
}
