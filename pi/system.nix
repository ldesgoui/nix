{ ... }: {

  boot.cleanTmpDir = true;

  documentation = {
    enable = false;
    dev.enable = false;
    doc.enable = false;
    man.enable = false;
    nixos.enable = false;
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;

  services.journald.extraConfig = "MaxRetentionSec=1week";

  system.stateVersion = "19.03";

  time.timeZone = "Europe/Paris";
}
