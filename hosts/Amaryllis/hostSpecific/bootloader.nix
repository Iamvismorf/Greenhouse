{
  boot.loader.systemd-boot.extraEntries."fedora.conf" = ''
    title Fedora
    efi /efi/fedora/grubx64.efi
  '';
}
