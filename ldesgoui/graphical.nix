# graphical.nix
{ pkgs, config, ... }:

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

  home.sessionVariables = {
    ICEAUTHORITY = "$XDG_CACHE_HOME/ICEauthority";
    # XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";
    XCOMPOSECACHE = "$XDG_CACHE_HOME/X11/xcompose";
    XCOMPOSEFILE = "$XDG_CONFIG_HOME/X11/xcompose";
  };

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

  programs.firefox = { enable = true; };

  programs.mpv = { enable = true; };

  # programs.obs-studio

  programs.zathura = { enable = true; };

  # services.compton

  services.dunst = { enable = true; };

  # services.redshift

  xsession = {
    enable = true;
    initExtra = ''
      xrandr -r 144
    '';

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };

  xdg.configFile."xmonad/xmonad.hs" = {
    source = ./xmonad.hs;
    onChange = ''
      echo "Recompiling xmonad"
      $DRY_RUN_CMD xmonad --recompile

      # Attempt to restart xmonad if X is running.
      if [[ -v DISPLAY ]] ; then
        echo "Restarting xmonad"
        $DRY_RUN_CMD xmonad --restart
      fi
    '';
  };
}
