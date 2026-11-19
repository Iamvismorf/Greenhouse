{
  modules.nixos.security = {
    security.sudo.extraConfig = ''
      Defaults env_keep += "EDITOR"
    '';
  };
}
