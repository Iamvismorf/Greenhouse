{
  sources,
  myLib,
  ...
}: let
  home = import sources.hjem {};
  qtengine = (myLib.flakeToNix {src = sources.qtengine;}).defaultNix;
in {
  hjem = {
    linker = home.packages.smfh;
    extraModules = [
      qtengine.hjemModules.default
    ];
  };
}
