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

  services.netdata = {
    enable = true;
    config.global = {
      "access log" = "syslog";
      "error log" = "syslog";
      "config directory" = let
        dir = pkgs.runCommand "netdata-conf.d" {} ''
          mkdir -p $out
          cp -r ${pkgs.netdata}/lib/netdata/conf.d/* $out
          chmod -R +w $out

          cat > $out/health_alarm_notify.conf << END

          SEND_EMAIL=YES
          role_recipients_email[sysadmin]=root
          role_recipients_email[domainadmin]=root
          role_recipients_email[dba]=root
          role_recipients_email[webmaster]=root
          role_recipients_email[proxyadmin]=root
          role_recipients_email[sitemgr]=root

          SEND_SYSLOG=YES
          role_recipients_syslog[sysadmin]=netdata
          role_recipients_syslog[domainadmin]=netdata
          role_recipients_syslog[dba]=netdata
          role_recipients_syslog[webmaster]=netdata
          role_recipients_syslog[proxyadmin]=netdata
          role_recipients_syslog[sitemgr]=netdata

          END
        '';
      in
        "${dir}";
    };
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."82.64.186.138" = {
      default = true;
      extraConfig = "return 301 https://ldesgoui.xyz$request_uri;";
    };

    virtualHosts."localhost" = {
      locations."/stub_status".extraConfig = ''
        stub_status;
        allow 127.0.0.1;
        deny all;
      '';
    };

    virtualHosts."ldesgoui.xyz" = {
      enableACME = true;
      forceSSL = true;
      root = "/var/www/ldesgoui.xyz";
    };

    virtualHosts."10.0.0.1" = {
      locations."= /netdata".extraConfig = "return 301 /netdata/;";
      locations."~ /netdata/(?<ndpath>.*)" = {
        proxyPass = "http://127.0.0.1:19999/$ndpath$is_args$args";
        extraConfig = ''
          proxy_pass_request_headers on;
          proxy_set_header Connection "keep-alive";
          proxy_store off;
        '';
      };
    };
  };

  users.groups.acme.members = [ "murmur" ];
}
