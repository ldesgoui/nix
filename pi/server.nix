{ lib, pkgs, ... }:
let
  snm =
    builtins.fetchTarball {
      url = (
        "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver"
        + "/-/archive/v2.3.0/nixos-mailserver-v2.3.0.tar.gz"
      );
      sha256 = "0lpz08qviccvpfws2nm83n7m2r8add2wvfg9bljx9yxx8107r919";
    };
in
{
  imports = [ snm ];

  mailserver = {
    certificateScheme = 3;
    domains = [ "ldesgoui.xyz" "ascent.gg" ];
    enable = true;
    fqdn = "ldesgoui.xyz";

    loginAccounts = {
      "ldesgoui@ldesgoui.xyz" = {
        hashedPassword = import ../secrets/email/ldesgoui.nix;
        catchAll = [ "ldesgoui.xyz" ];
        aliases = [ "@pi.ldesgoui.xyz" "@localhost" ];
      };

      "wyatt@ascent.gg" = {
        hashedPassword = import ../secrets/email/wyatt.nix;
        catchAll = [ "ascent.gg" ];
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    email = "ldesgoui@gmail.com";

    certs."ldesgoui.xyz" = {
      allowKeysForGroup = true;
      group = "acme";
      postRun = "systemctl restart murmur.service";
    };
  };

  services.fail2ban = {
    enable = true;

    jails.DEFAULT = lib.mkForce ''
      backend = systemd
      bantime = 7200
      findtime = 3600
      ignoreip = 127.0.0.1/8 192.168.0.0/16 10.0.0.0/24 ::1 fe80::/10 2a01:e0a:260:6380::/60
      maxretry = 5
    '';

    jails.postfix = ''
      enabled = true
      filter = postfix[mode=aggressive]
      action = iptables-allports[name=postfix, protocol=tcp]
    '';

    jails.dovecot = ''
      enabled = true
      filter = dovecot[mode=aggressive]
      action = iptables-allports[name=dovecot, protocol=tcp]
    '';
  };

  services.kresd = {
    enable = true;
    listenPlain = [ "127.0.0.1:53" "10.0.0.1:53" ];
    listenTLS = [ "127.0.0.1:853" "10.0.0.1:853" ];
    extraConfig = ''
      modules = { "hints" }

      hints["pi.wg0"] = "10.0.0.1"
      hints["desktop.wg0"] = "10.0.0.2"
      hints["op5.wg0"] = "10.0.0.3"
    '';
  };


  services.murmur = {
    enable = true;
    bandwidth = 320000;
    imgMsgLength = 1024 * 1024 * 10;
    registerName = "ldesgoui.xyz";
    sslCert = "/var/lib/acme/ldesgoui.xyz/fullchain.pem";
    sslKey = "/var/lib/acme/ldesgoui.xyz/key.pem";
    welcometext = "[W̲̅E̲̅L̲̅C̲̅O̲̅M̲̅E̲̅·̲̅T̲̅O̲̅·̲̅T̲̅H̲̅E̲̅·̲̅M̲̅U̲̅M̲̅B̲̅L̲̅E̲̅·̲̅S̲̅E̲̅R̲̅V̲̅E̲̅R̲̅]";
  };

  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."82.64.186.138" = {
      default = true;
      globalRedirect = "ldesgoui.xyz";
    };

    virtualHosts."ldesgoui.xyz" = {
      enableACME = true;
      forceSSL = true;
      serverAliases = [ "www.ldesgoui.xyz" ];

      root = "/var/www/ldesgoui.xyz";

      extraConfig = ''
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains";
        add_header Expect-CT 'max-age=604800, report-uri="https://ldesgoui.report-uri.com/r/d/ct/enforce"';
        add_header Feature-Policy "default 'self'";
        add_header NEL '{"report_to": "default", "max_age": 31536000, "include_subdomains": true}';
        add_header Referrer-Policy "strict-origin-when-cross-origin";
        add_header Report-To '{"group": "default", "max_age": 31536000, "endpoints": [{"url": "https://ldesgoui.report-uri.com/a/d/g"}], "include_subdomains": true}';
        add_header X-Content-Type-Options "nosniff";
        add_header X-Frame-Options "DENY";
        add_header X-Xss-Protection "1; mode=block; report=https://ldesgoui.report-uri.com/r/d/xss/enforce";
      '';
    };

    virtualHosts."pi.wg0" = {
      listen = [ { addr = "10.0.0.1"; port = 80; } ];
      locations."/ip".return = "200 $remote_addr";
    };
  };

  users.groups.acme.members = [ "murmur" ];
}
