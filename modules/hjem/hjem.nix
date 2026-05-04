{inputs, ...}: let
in {
  modules.hjem._ = {pkgs, ...}: {
    imports = [inputs.hjem.nixosModules.default];

    hjem = {
      linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;

      extraModules = [
        inputs.qtengine.hjemModules.default
      ];
    };
  };
}
