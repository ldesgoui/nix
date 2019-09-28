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

in
{
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
    ICEAUTHORITY = "${config.xdg.cacheHome}/ICEauthority";
    # XAUTHORITY = "\${XDG_RUNTIME_DIR:-/run/user/\$(id -u)}/Xauthority"; # breaks stuff
    XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
    XCOMPOSEFILE = "${config.xdg.configHome}/X11/xcompose";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      selection.save_to_clipboard = true;
      font.size = 12;
      font.normal.family = font;
      window.padding = { x = 4; y = 4; };

      colors = {
        primary.background = "0x1d1f21";
        primary.foreground = "0xc5c8c6";
        cursor.text = "0x1d1f21";
        cursor.cursor = "0xffffff";
        normal.black = "0x1d1f21";
        normal.red = "0xcc6666";
        normal.green = "0xb5bd68";
        normal.yellow = "0xe6c547";
        normal.blue = "0x81a2be";
        normal.magenta = "0xb294bb";
        normal.cyan = "0x70c0ba";
        normal.white = "0x373b41";
        bright.black = "0x666666";
        bright.red = "0xff3334";
        bright.green = "0x9ec400";
        bright.yellow = "0xf0c674";
        bright.blue = "0x81a2be";
        bright.magenta = "0xb77ee0";
        bright.cyan = "0x54ced6";
        bright.white = "0x282a2e";
      };
    };
  };

  programs.feh.enable = true;

  programs.firefox = {
    enable = true;
  };

  programs.mpv.enable = true;

  programs.zathura.enable = true;

  services.dunst = {
    enable = true;
    settings.global = {
      geometry = "0x5-20+20";
      font = "${font} 12";
      padding = 8;
      horizontal_padding = 8;
    };
  };

  xsession = {
    enable = true;

    initExtra = ''
      xrandr -r 144
    '';

    pointerCursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };

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
