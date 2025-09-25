let
  pkgs = import (import ./npins).nixpkgs {};
in
  pkgs.mkShell {
    nativeBuildInputs = [
      pkgs.nix
      pkgs.npins
    ];

    shellHook = ''
      echo "nix-shell"
      export NIX_PATH="nixpkgs=${builtins.storePath pkgs.path}"
    '';
  }
