let
  sources = removeAttrs (import ./+npins) ["__functor"];
  unflake = import sources.flake-compat;
  lib = import "${sources.nixpkgs}/lib";

  notFlakes = ["zenNvim" "npins" "flake-inputs" "flake-compat" "qtengine" "blink-cmp"];

  outputs = sources:
    builtins.mapAttrs (
      _: input:
        if input.flake or false
        then (unflake {src = input.source;}).outputs // {cleanSrc = input.source;}
        # then (builtins.getFlake input.source.url) // {cleanSrc = input.source;}
        else input.source
    )
    sources;
in
  #
  outputs ((builtins.mapAttrs (_: source: {
        source = source;
        flake = true;
      })
      sources)
    // lib.genAttrs notFlakes (k: {
      flake = false;
      source = sources.${k};
    }))
