{ myLib, ... }:
{
 # imports = [
 #   ./systemPackages.nix
 #   ./bootloader.nix
 #   ./garbAge.nix
 #   # ./steam.nix
 # ];
 # imports = myLib.importDir {dir = ./.; eF = [ "./default.nix" "./steam.nix"];};

  imports = myLib.importDir {
    dir = ./.;
    eF = ["default.nix" "opentablet.nix"];
    subdir = true;
  };


}
