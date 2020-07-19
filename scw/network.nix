{ ... }: {
  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 51820 ];
    trustedInterfaces = [ "wg0" ];
  };

  networking.useDHCP = false;
  networking.interfaces.ens2.useDHCP = true;

  networking = {
    domain = "ldesgoui.xyz";
    hostName = "scw-elegant-shockley";
  };

  # networking.interfaces."eth0".ipv6.addresses = [
  #   {
  #     address = "2a01:e0a:260:6380::";
  #     prefixLength = 64;
  #   }
  # ];

  networking.nat = {
    enable = true;
    externalInterface = "ens2";
    internalInterfaces = [ "wg0" ];
  };
}
