# network.nix
{ ... }: {
  networking = {
    hostName = "desktop";
    domain = "ldesgoui.xyz";

    nameservers = [ "10.77.67.1" "1.1.1.1" ];

    firewall = {
      allowedTCPPorts = [ 24800 64738 44444 ];
      allowedUDPPorts = [ 27015 64738 44400 ];
      trustedInterfaces = [ "wg0" ];
    };

    wireguard.interfaces.wg0 = {
      ips = [ "10.77.67.2/24" ];

      privateKeyFile = "/root/wireguard/private";

      peers = [
        {
          publicKey = "QDEuEy768a+sQ2w+jvAzx2OJmHHgcaPpKQlifVFgzF0=";
          allowedIPs = [ "10.77.67.1" ];
          endpoint = "ldesgoui.xyz:51820";
        }
      ];
    };
  };

  # services.openssh = {
  #   enable = true;
  #   passwordAuthentication = false;
  # };
}
