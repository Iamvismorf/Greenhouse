let
  src = import ./+npins;
  pkgs = import src.nixpkgs {};
in
  pkgs.mkShell {
    NPINS_DIRECTORY = "+npins";
  }
