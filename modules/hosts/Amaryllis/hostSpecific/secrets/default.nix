{self, ...}: {
  modules.hosts.Amaryllis = {
    sops = {
      # defaultSopsFile = ../../../../../secrets/Amaryllis/ddns.yaml;
      defaultSopsFile = "${self}/secrets/Amaryllis/ddns.yaml";
      age = {
        sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
    };
  };
}
