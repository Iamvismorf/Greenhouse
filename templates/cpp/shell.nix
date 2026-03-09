let
  src = import ./npins;
  pkgs = import src.nixpkgs {};
in
  pkgs.mkShell {
    packages = [
      pkgs.just
      pkgs.llvmPackages.clang-tools
    ];
    # dependencies that should exist in the runtime environment

    buildInputs = [
    ];

    # dependencies that should exist in the build environment
    nativeBuildInputs = [
      pkgs.cmake
      pkgs.pkg-config
      pkgs.ninja
    ];
  }
