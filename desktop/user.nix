# user.nix
{ ... }: {
  hardware.pulseaudio.enable = true;

  nixpkgs.config.pulseaudio = true;

  programs.bash.enableCompletion = true;

  services.xserver = {
    desktopManager.xterm.enable = false;

    displayManager.auto = {
      enable = true;
      user = "ldesgoui";
    };

    enable = true;

    libinput.enable = true;

    xkbOptions = "ctrl:nocaps";
  };

  sound.enable = true;

  users.users.ldesgoui = {
    extraGroups = [ "wheel" ];

    isNormalUser = true;

    uid = 4242;
  };
}
