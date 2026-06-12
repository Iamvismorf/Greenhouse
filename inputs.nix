#hellow
let
  sources = removeAttrs (import ./+npins) ["__functor"];
  unflake = (import sources.flake-inputs).import-flake;

  outputs = sources:
    builtins.mapAttrs (
      _: input:
        if builtins.pathExists "${input}/flake.nix" && !(input ? raw)
        then
          (unflake {
            src = input;
            overrides = {nixpkgs = sources.nixpkgs.outPath;} // (input.overrides or {});
          })
        else input
    )
    sources;
in
  outputs (sources
    // {
    })
