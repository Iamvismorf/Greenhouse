let
  src = import ./npins;
  pkgs = import src.nixpkgs {};
in
  pkgs.mkShell {
    packages = [
      pkgs.just
    ];

    # dependencies that should exist in the runtime environment
    buildInputs = [
      pkgs.glslviewer
      pkgs.glsl_analyzer
    ];

    # dependencies that should exist in the build environment
    nativeBuildInputs = [
    ];
  }
