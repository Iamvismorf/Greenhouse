#todo: add formaters for config langs
let
  src = import ./+tack;
  pkgs = import src.nixpkgs {};
in
  pkgs.mkShell {
    TACK_DIR = "+tack";
    IMPURE = "true";

    shellHook = ''
      export NIX_PATH="nixpkgs=${src.nixpkgs.outPath}"
    '';
  }
