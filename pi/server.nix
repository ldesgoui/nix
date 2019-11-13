{ lib, pkgs, ... }:

let
  snm =
    builtins.fetchTarball {
      url = (
        "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver"
        + "/-/archive/v2.2.1/nixos-mailserver-v2.2.1.tar.gz"
      );
      sha256 = "03d49v8qnid9g9rha0wg2z6vic06mhp0b049s3whccn1axvs2zzx";
    };
in
{
  imports = [ snm ];

  mailserver = {
    certificateScheme = 3;
    domains = [ "ldesgoui.xyz" ];
    enable = true;
    fqdn = "ldesgoui.xyz";

    loginAccounts."ldesgoui@ldesgoui.xyz" = {
      hashedPassword = import ../secrets/emailHashedPassword.nix;
      catchAll = [ "ldesgoui.xyz" ];
      aliases = [ "@pi.home.ldesgoui.xyz" "@home.ldesgoui.xyz" "@localhost" ];
    };
  };

  security.acme.certs."ldesgoui.xyz" = {
    allowKeysForGroup = true;
    group = "acme";
    postRun = "systemctl restart murmur.service";
  };

  services.fail2ban = {
    enable = true;

    jails.DEFAULT = lib.mkForce ''
      enabled = true
      backend = systemd
      bantime = 7200
      findtime = 3600
      ignoreip = 127.0.0.1/8 192.168.0.0/16 10.0.0.0/24
      maxretry = 5
    '';

    jails.postfix = ''
      filter = postfix[mode=aggressive]
      action = iptables-allports[name=postfix, protocol=tcp]
    '';

    jails.dovecot = ''
      filter = dovecot[mode=aggressive]
      action = iptables-allports[name=dovecot, protocol=tcp]
    '';
  };

  services.murmur = {
    enable = true;
    registerName = "ldesgoui.xyz";
    sslCert = "/var/lib/acme/ldesgoui.xyz/fullchain.pem";
    sslKey = "/var/lib/acme/ldesgoui.xyz/key.pem";
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."82.64.186.138" = {
      default = true;
      enableACME = true;
      globalRedirect = "ldesgoui.xyz";
      serverAliases = [ "www.ldesgoui.xyz" "home.ldesgoui.xyz" ];
    };

    virtualHosts."ldesgoui.xyz" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/ldesgoui.xyz";
    };
  };

  users.groups.acme.members = [ "murmur" ];
}
