# hardware.nix
{ pkgs, ... }: {
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
      kernelModules = [];
    };

    extraModulePackages = [];

    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "radeon.si_support=0"
      "amdgpu.si_support=1"
      "radeon.cik_support=0"
      "amdgpu.cik_support=1"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
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
    cpu.intel.updateMicrocode = true;

    enableRedistributableFirmware = true;

    opengl.driSupport32Bit = true;

    pulseaudio.support32Bit = true;

    steam-hardware.enable = true;
  };

  services.fstrim.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
}
