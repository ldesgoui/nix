# graphical.nix
{ pkgs, ... }:

let
  font =
    # "Andale Mono"
    # "Anonymous Pro"
    "Cascadia Code"
    # "Cousine"
    # "Cutive Mono"
    # "DejaVu Sans Mono"
    # "Fira Mono"
    # "IBM Plex Mono"
    # "Inconsolata"
    # "NovaMono"
    # "PT Mono"
    # "Source Code Pro"
    # "Space Mono"
    # "Ubuntu Mono"
  ;

in {
  imports = [ ./home.nix ];

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    corefonts
    dmenu
    emojione
    gimp
    google-fonts
    iosevka
    maim
    mumble
    pavucontrol
    vulkan-loader
    xclip
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      selection.save_to_clipboard = true;
      font.size = 12;
      font.normal.family = font;
    };
  };

  programs.feh.enable = true;

  # programs.firefox = {
  #   enable = true;
  # };

  programs.mpv = { enable = true; };

  # programs.obs-studio

  programs.zathura = { enable = true; };

  # services.compton

  services.dunst = { enable = true; };

  # services.redshift

  # xresources

  xsession = {
    enable = true;
    initExtra = ''
      xrandr -r 144
    '';

    scriptPath = ".local/bin/xsession";

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      # config = pkgs.writeText "xmonad.hs" ''

    };
  };

}
