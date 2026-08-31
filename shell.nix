#todo: add formaters for config langs
let
  sources = import ./+npins;
  pkgs = import sources.nixpkgs {};
in
  pkgs.mkShell {
    NPINS_DIRECTORY = "+npins";
    IMPURE = "true";
    packages = [
      pkgs.tokei
    ];

    shellHook = ''
      export NIX_PATH="nixpkgs=$(npins get-path nixpkgs)"

      export NIX_CONFIG="
      plugin-files = "${pkgs.callPackage ./lib/extraBuiltins {}}/lib/nix/plugins"
      "

      export NIXD_FLAGS="
      --nixos-options-expr=\"(import ./evaledConfig.nix).options // (import ./evaledConfig.nix).config.nC.$(hostname).options\" \
      --nixpkgs-expr=\"import ${sources.nixpkgs} {}\"
      "
    '';
  }
