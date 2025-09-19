let
  pkgs = import (import ./npins).nixpkgs {};
in
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
      nix
      git
      npins
    ];

    shellHook = ''
      echo "nix-shell"
      export NIX_PATH="nixpkgs=${builtins.storePath pkgs.path}"
    '';
  }
