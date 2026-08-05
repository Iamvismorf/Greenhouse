{
  stdenv,
  cmake,
  pkg-config,
  nixVersions,
  nix,
}:
stdenv.mkDerivation {
  pname = "nix-plugins";
  # version = "v${nixVersions.git.version}";
  version = "v${nix.version}";
  src = ./.;

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    # nixVersions.nixComponents_git.nix-expr
    nix
  ];
}
