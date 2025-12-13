# let
#   pkgs = import <nixpkgs> {};
# in
#   pkgs.mkShell {
#     buildInputs = [
#       pkgs.qt6Packages.qtdeclarative
#       pkgs.qt6Packages.qtbase
#       pkgs.qt6Packages.full
#       pkgs.qt6.wrapQtAppsHook
#       pkgs.cmake
#       pkgs.makeWrapper
#     ];
#     shellHook = ''
#       setQtEnvironment=$(mktemp)
#       random=$(openssl rand -base64 20 | sed "s/[^a-zA-Z0-9]//g")
#       makeShellWrapper "$(type -p sh)" "$setQtEnvironment" "''${qtWrapperArgs[@]}" --argv0 "$random"
#       sed "/$random/d" -i "$setQtEnvironment"
#       source "$setQtEnvironment"
#     '';
#   }
let
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    packages = with pkgs.qt6Packages; [
      qtbase
      qtdeclarative
      # full
    ];

    buildInputs = [
      pkgs.cmake
      pkgs.rocmPackages.amdsmi
    ];

    nativeBuildInputs = [
      pkgs.qt6.wrapQtAppsHook
      pkgs.makeWrapper
    ];

    # Qt 6 specific environment variables
    shellHook = ''
        export QT_PLUGIN_PATH="$HOME/c++/hardwareInfoPlugin/build/:${pkgs.qt6.qtbase}/${pkgs.qt6.qtbase.qtPluginPrefix}"
        export QML_IMPORT_PATH="$HOME/c++/hardwareInfoPlugin/build/:${pkgs.qt6.qtdeclarative}/${pkgs.qt6.qtbase.qtQmlPrefix}"
        setQtEnvironment=$(mktemp)
      random=$(openssl rand -base64 20 | sed "s/[^a-zA-Z0-9]//g")
      makeShellWrapper "$(type -p sh)" "$setQtEnvironment" "''${qtWrapperArgs[@]}" --argv0 "$random"
      sed "/$random/d" -i "$setQtEnvironment"
      source "$setQtEnvironment"
    '';
  }
