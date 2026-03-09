{
  sources,
  myLib,
  pkgs,
  ...
}: let
  qtengine = (myLib.flakeToNix {src = sources.qtengine;}).defaultNix;
  hjemOut = (myLib.flakeToNix {src = sources.hjem;}).defaultNix;
in {
  imports = [
  ];
  hjem = {
    linker = hjemOut.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
    extraModules = [
      qtengine.hjemModules.default
    ];
  };
}
