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
  environment.systemPackages = with pkgs; [ vim ];

  i18n.supportedLocales = lib.mkForce [ "en_US.UTF-8/UTF-8" ];

  # nix.gc = {
  #   automatic = true;
  #   options = "--delete-older-than 30d";
  # };

  # nixpkgs.config.allowUnfree = true;

  services.journald.extraConfig = "MaxRetentionSec=1month";

  # swapDevices = [{ device = "/var/swap"; size = 4096; }];

  system.stateVersion = "20.09";

  time.timeZone = "Europe/Paris";
}
