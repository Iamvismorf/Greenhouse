#todo: add formaters for config langs
let
  sources = import ./+tack;
  pkgs = import sources.nixpkgs {};
in
  pkgs.mkShell {
    TACK_DIR = "+tack";
    IMPURE = "true";

    packages = [
      sources.tack.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    shellHook = ''
      export NIX_PATH="nixpkgs=${sources.nixpkgs.outPath}"
    '';
  }
