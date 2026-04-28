let
  sources = import ./+npins;
  flake-inputs = import sources.flake-inputs;

  outputs = sources:
    builtins.mapAttrs (
      _: input:
        if builtins.pathExists "${input}/flake.nix" && !(input ? raw)
        then
          (flake-inputs.import-flake {
            src = input;
            overrides = {nixpkgs = sources.nixpkgs.outPath;};
          })
        else input
    )
    sources;
in {
  inputs = outputs sources;
}
