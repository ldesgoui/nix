# system.nix
{ ... }: {
  boot.cleanTmpDir = true;

  nix = {
    autoOptimiseStore = true;

    buildCores = 4;

    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };

    maxJobs = 4;
  };

  nixpkgs.config.allowUnfree = true;

  services.journald.extraConfig = "MaxRetentionSec=1month";

  swapDevices = [
    {
      device = "/var/swap";
      size = 4096;
    }
  ];

  system.stateVersion = "18.09";

  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  time.timeZone = "Europe/Paris";
}
