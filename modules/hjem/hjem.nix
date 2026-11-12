{
  self,
  inputs,
  ...
}: let
in {
  modules.hjem._ = {pkgs, ...}: {
    imports = [
      inputs.hjem.nixosModules.default
      self.modules.hjem.options #todo move this to hjem.extramodules
      self.modules.hjem.metadata
    ];

    hjem = {
      linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;

      extraModules = [
        inputs.qtengine.hjemModules.default
      ];
    };
  };
}
