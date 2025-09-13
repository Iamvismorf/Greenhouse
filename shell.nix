let
  pkgs = import (import ./npins).nixpkgs { };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # I recommend also pinning all the local deployment tools while we're at it
    nix
    git
    npins
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${builtins.storePath pkgs.path}"
  '';
}

