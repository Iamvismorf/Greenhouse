{
  sources,
  myLib,
  pkgs,
  ...
}: let
  qtengineOut = (myLib.flakeToNix {src = sources.qtengine;}).defaultNix;
  hjemOut = (myLib.flakeToNix {src = sources.hjem;}).defaultNix;
in {
  imports = [
    hjemOut.nixosModules.default
  ];
  hjem = {
    linker = hjemOut.packages.${pkgs.stdenv.hostPlatform.system}.smfh;

    extraModules = [
      qtengineOut.hjemModules.default
    ];
  };
}
