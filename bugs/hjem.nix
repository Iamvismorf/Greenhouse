{
  sources,
  myLib,
  ...
}: let
  hjemOut = import sources.hjem {};
  qtengineOut = (myLib.flakeToNix {src = sources.qtengine;}).defaultNix;
in {
  imports = [
    hjemOut.nixosModules.default
  ];
  hjem = {
    linker = hjemOut.packages.smfh;

    extraModules = [
      qtengineOut.hjemModules.default
    ];
  };
}
