{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "ata_piix" "virtio_pci" "virtio_blk" "aesni-intel" "cryptd" ];
  boot.kernelModules = [ "kvm-amd" ];

  boot.initrd.network = {
    enable = true;

    ssh = {
      enable = true;
      port = 41022;
      authorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTmas/twTjDH6lyQIRxyrVMv1t23mf8IJIIqWVla5i5 ldesgoui@desktop"
      ];
      hostKeys = [ /etc/secrets/initrd/ssh_host_ed25519_key ];
    };

    postCommands = ''
      echo 'cryptsetup-askpass' >> /root/.profile
    '';
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c21ff95c-1aaf-4cea-ada9-16c12da320e7";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."crypted".device = "/dev/disk/by-uuid/467fdffa-9cb2-402e-b9e7-5ba7bf4a4dd3";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B3E7-7040";
    fsType = "vfat";
  };
}
