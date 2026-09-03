let
  sources = import ./+npins;

  evalFlakeUnwraped = (import sources.flake-inputs).import-flake;
  evalFlake = {
    src,
    overrides ? {},
  }:
    if builtins.pathExists "${src}/flake.nix"
    then
      evalFlakeUnwraped {
        inherit src overrides;
      }
    else src;
in rec {
  nixpkgs = evalFlake {
    src = sources.nixpkgs;
  };
  ghostty = evalFlake {
    src = sources.ghostty;
    overrides = {
      nixpkgs = nixpkgs.outPath;
    };
  };
  hjem = evalFlake {
    src = sources.hjem;
    overrides = {
      nixpkgs = nixpkgs.outPath;
    };
  };
  hyprland = evalFlake {
    src = sources.hyprland;
    overrides = {
      nixpkgs = nixpkgs.outPath;
    };
  };
  mnw = evalFlake {
    src = sources.mnw;
    overrides = {
      nixpkgs = nixpkgs.outPath;
    };
  };
  neovim-nightly = evalFlake {
    src = sources.neovim-nightly;
    overrides = {
      nixpkgs = nixpkgs.outPath;
    };
  };
  niri = evalFlake {
    src = sources.niri;
    overrides = {
      nixpkgs = nixpkgs.outPath;
    };
  };
  nixos-hardware = evalFlake {
    src = sources.nixos-hardware;
  };
  npins = evalFlake {
    src = sources.npins;
    overrides = {
      nixpkgs = nixpkgs.outPath;
    };
  };
  qtengine = evalFlake {
    src = sources.qtengine;
    overrides = {
      nixpkgs = nixpkgs.outPath;
    };
  };
  quickshell = evalFlake {
    src = sources.quickshell;
    overrides = {
      nixpkgs = nixpkgs.outPath;
    };
  };
  relative-motions-yazi = evalFlake {
    src = sources.relative-motions-yazi;
  };
  snippy = evalFlake {
    src = sources.snippy;
    overrides = {
      nixpkgs = nixpkgs.outPath;
    };
  };
}
