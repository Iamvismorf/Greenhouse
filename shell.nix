#todo: add formaters for config langs
let
  src = import ./+tack;
  pkgs = import src.nixpkgs {};
in
  pkgs.mkShell {
    NPINS_DIRECTORY = "+npins";
    TACK_DIR = "+tack";
    IMPURE = "true";
    #fuck

    shellHook = ''
      # export NIX_PATH="nixpkgs=$(npins get-path nixpkgs)"
      export NIX_PATH="nixpkgs=${src.nixpkgs.outPath}"
    '';
  }
