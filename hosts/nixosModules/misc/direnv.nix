{
  programs.direnv = {
    enable = true;
    loadInNixShell = true;
    nix-direnv.enable = true;
    enableFishIntegration = true;
  };
}
