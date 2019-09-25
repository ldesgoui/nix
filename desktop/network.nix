# network.nix
{ ... }: {
  networking = {
    hostName = "desktop.home.ldesgoui.xyz";

    nameservers =
      [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];

    firewall.trustedInterfaces = [ "wg0" ];

    wireguard.interfaces.wg0 = {
      ips = [ "10.0.0.2/24" ];

      privateKeyFile = "/root/wireguard/private";

      peers = [{
        publicKey = "QDEuEy768a+sQ2w+jvAzx2OJmHHgcaPpKQlifVFgzF0=";

        allowedIPs = [ "10.0.0.1" ];

        endpoint = "home.ldesgoui.xyz:51820";
      }];
    };
  };

  services.openssh.enable = true;
}
