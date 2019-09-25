# hardware.nix
{ ... }: {
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    extraModulePackages = [ ];

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
    "/".device = "/dev/disk/by-label/nixos";
    "/boot".device = "/dev/disk/by-label/boot";
  };

  hardware = {
    cpu.intel.updateMicrocode = true;

    enableAllFirmware = true;

    opengl.driSupport32Bit = true;

    pulseaudio.support32Bit = true;
  };

  services.fstrim.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
}
