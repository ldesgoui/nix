{ lib, ... }: {

  boot.cleanTmpDir = true;

  documentation = {
    enable = false;
    dev.enable = false;
    doc.enable = false;
    man.enable = false;
    nixos.enable = false;
  };

  environment.noXlibs = true;

  i18n.supportedLocales = lib.mkForce [ "en_US.UTF-8/UTF-8" ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;

  services.journald.extraConfig = "MaxRetentionSec=1week";

  swapDevices = [{ device = "/var/swap"; size = 4096; }];

  system.stateVersion = "19.03";

  time.timeZone = "Europe/Paris";
}
