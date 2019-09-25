{ pkgs, ... }: {
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.consoleLogLevel = 7;

  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.grub.enable = false;
  boot.loader.raspberryPi = {
    enable = true;
    firmwareConfig = "gpu_mem=16";
    uboot.enable = true;
    uboot.maxConfigurations = 5;
    version = 3;
  };

  environment.systemPackages = with pkgs; [
    raspberrypi-tools
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };
}
