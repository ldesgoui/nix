# network.nix
{ ... }: {
  networking = {
    hostName = "desktop";
    domain = "ldesgoui.xyz";

    nameservers = [ "10.0.0.1" ];

    firewall.trustedInterfaces = [ "wg0" ];

    wireguard.interfaces.wg0 = {
      ips = [ "10.0.0.2/24" ];

      privateKeyFile = "/root/wireguard/private";

      peers = [
        {
          publicKey = "QDEuEy768a+sQ2w+jvAzx2OJmHHgcaPpKQlifVFgzF0=";
          allowedIPs = [ "10.0.0.1" ];
          endpoint = "ldesgoui.xyz:51820";
        }
      ];
    };
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };
}
