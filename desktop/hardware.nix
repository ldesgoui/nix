# hardware.nix
{ pkgs, ... }: {
  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "sd_mod" ];

    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "quiet"
      "iommu=soft"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      timeout = 1;
    };
  };

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

  hardware = {
    cpu.amd.updateMicrocode = true;

    enableRedistributableFirmware = true;

    opengl.driSupport32Bit = true;

    pulseaudio.support32Bit = true;

    steam-hardware.enable = true;
  };

  services.fstrim.enable = true;

  # services.ratbagd.enable = true;

  # services.xserver.videoDrivers = [ "amdgpu" ];
  # hardware.video.hidpi.enable = true;
  boot.loader.systemd-boot.memtest86.enable = true;
}
