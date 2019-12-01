# system.nix
{ ... }: {
  boot.cleanTmpDir = true;

  nix = {
    autoOptimiseStore = true;

    buildCores = 4;

    maxJobs = 4;
  };

  nixpkgs.config.allowUnfree = true;

  services.journald.extraConfig = "MaxRetentionSec=1month";

  system.stateVersion = "18.09";

  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  time.timeZone = "Europe/Paris";
}
