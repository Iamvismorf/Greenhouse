{
  modules.hosts.Amaryllis = {config, ...}: {
    services.ddclient = {
      enable = true;
      verbose = true;
      protocol = "dyndns2";
      ssl = true;
      interval = "24h";
      usev6 = "ifv6, ifv6=eno1";
      server = "www.dnshome.de";
      username = "amaryllis.dnshome.eu";
      passwordFile = config.sops.secrets."ddns/password".path;
      domains = [
        "amaryllis.dnshome.eu"
      ];
    };
  };
}
