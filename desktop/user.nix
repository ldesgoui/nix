# user.nix
{ pkgs, ... }: {
  fonts.fontconfig = {
    allowBitmaps = true;
    useEmbeddedBitmaps = true;
  };

  hardware.pulseaudio.enable = true;

  nixpkgs.config.pulseaudio = true;

  programs.bash.enableCompletion = true;

  # https://github.com/rycee/home-manager/pull/510
  services.dbus.packages = [ pkgs.gnome3.dconf ];

  services.xserver = {
    desktopManager.xterm.enable = false;

    displayManager.autoLogin = {
      enable = true;
      user = "ldesgoui";
    };

    displayManager.lightdm = {
      enable = true;
    };

    displayManager.defaultSession = "none+xmonad";

    enable = true;

    libinput = {
      enable = true;
      middleEmulation = false;
    };

    windowManager.xmonad.enable = true;

    xkbOptions = "ctrl:nocaps";
  };

  sound.enable = true;

  # users.mutableUsers = false;

  users.users.ldesgoui = {
    extraGroups = [ "wheel" "vboxusers" "docker" ];
    isNormalUser = true;
    uid = 4242;
  };

  services.jellyfin.enable = true;
  services.jellyfin.package = pkgs.jellyfin;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
}
