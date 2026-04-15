let
  sources = import ../+npins;
  flake-inputs = import sources.flake-inputs;
in
  {
    src,
    overrides ? {},
  }:
    (flake-inputs.import-flake {inherit src overrides;}).self.outputs
