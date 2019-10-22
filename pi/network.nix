{ ... }: {
  networking = {
    hostName = "pi.home.ldesgoui.xyz";
    nameservers =
      [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 64738 ];
    allowedUDPPorts = [ 51820 64738 ];
    trustedInterfaces = [ "wg0" ];
  };

  networking.nat = {
    enable = true;
    externalInterface = "eth0";
    internalInterfaces = [ "wg0" ];
  };

  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.1/24" ];
    listenPort = 51820;
    privateKeyFile = "/root/wireguard/private";
    peers = [
      {
        publicKey = "2HUQtcDlbAiX9Cy330xU5OEB3t3I/appNF6kuURui1I=";
        allowedIPs = [ "10.0.0.2/32" ];
      }
      {
        publicKey = "WfOd0Wua8KLTjP1dyvm1xa3AHgrwWCfO86ZiaJ4tHBs=";
        allowedIPs = [ "10.0.0.3/32" ];
      }
    ];
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };
}