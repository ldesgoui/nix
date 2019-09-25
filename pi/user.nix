{ ... }: {
  users.users.ldesgoui = {
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK25ea20daUVvmTPmUL1nF/0DXEz/7tPBXOSerQNTf6+ ldesgoui@ldesgoui.xyz"
    ];
    uid = 4242;
  };
}
