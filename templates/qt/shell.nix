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
      pkgs.qt6.qtbase
      pkgs.qt6.qtdeclarative
    ];

    # dependencies that should exist in the build environment
    nativeBuildInputs = [
      pkgs.cmake
      pkgs.pkg-config
      pkgs.ninja
    ];

    shellHook = ''
      export CMAKE_BUILD_PARALLEL_LEVEL=$(nproc)
      export QML_IMPORT_PATH="$PWD/build/:${pkgs.qt6.qtdeclarative}/${pkgs.qt6.qtbase.qtQmlPrefix}"

      # Add Qt-related environment variables.
      # https://discourse.nixos.org/t/qt-development-environment-on-a-flake-system/23707/5
      setQtEnvironment=$(mktemp)
      random=$(openssl rand -base64 20 | sed "s/[^a-zA-Z0-9]//g")
      makeShellWrapper "$(type -p sh)" "$setQtEnvironment" "''${qtWrapperArgs[@]}" --argv0 "$random"
      sed "/$random/d" -i "$setQtEnvironment"
      source "$setQtEnvironment"

      # qmlls does not account for the import path and bases its search off qtbase's path.
      # The actual imports come from qtdeclarative. This directs qmlls to the correct imports.
      export QMLLS_BUILD_DIRS=$(pwd)/build:$QML2_IMPORT_PATH
    '';
  }
