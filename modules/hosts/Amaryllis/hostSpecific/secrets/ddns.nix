{self, ...}: {
  modules.hosts.Amaryllis = {
    sops.secrets = {
      "ddns/password" = {
        sopsFile = "${self}/secrets/Amaryllis/ddns.yaml";
      };
    };
  };
}
