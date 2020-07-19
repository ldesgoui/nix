{ ... }: {
  users.users.ldesgoui = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTmas/twTjDH6lyQIRxyrVMv1t23mf8IJIIqWVla5i5 ldesgoui@desktop"
    ];
  };
}
