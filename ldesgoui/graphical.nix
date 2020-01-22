# graphical.nix
{ pkgs, config, ... }:

let
  font =
    # "Andale Mono"
    # "Anonymous Pro"
    # "Cascadia Code"
    # "Cousine"
    # "Cutive Mono"
    # "DejaVu Sans Mono"
    # "Fantasque Sans Mono"
    # "Fira Mono"
    # "Hack"
    # "IBM Plex Mono"
    # "Inconsolata"
    "Iosevka"
    # "NovaMono"
    # "PT Mono"
    # "Source Code Pro"
    # "Space Mono"
    # "Ubuntu Mono"
    # "Victor Mono"
  ;

in
{
  imports = [ ./home.nix ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    font.name = "${font} 11";
    theme = {
      package = pkgs.stilo-themes;
      name = "Stilo-dark";
    };
  };

  home.packages = with pkgs; [
    aria2
    chatterino2
    dmenu
    gimp
    libnotify
    maim
    mumble_git
    pamixer
    pavucontrol
    streamlink
    vulkan-loader
    xclip
  ] ++ # fonts
  [
    corefonts
    emojione
    fantasque-sans-mono
    google-fonts
    hack-font
    iosevka
    victor-mono
  ];

  home.sessionVariables = {
    ICEAUTHORITY = "${config.xdg.cacheHome}/ICEauthority";
    # XAUTHORITY = "\${XDG_RUNTIME_DIR:-/run/user/\$(id -u)}/Xauthority"; # breaks stuff
    XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
    XCOMPOSEFILE = "${config.xdg.configHome}/X11/xcompose";
  };

  nixpkgs.overlays = [
    (
      self: super: {
        chatterino2 = super.libsForQt5.callPackage ./packages/chatterino2.nix {};
      }
    )
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = { x = 4; y = 4; };
      font = { normal.family = font; size = 10; };
      selection.save_to_clipboard = true;
    };
  };

  programs.feh.enable = true;

  programs.firefox.enable = true;

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
      xsetroot -solid black
      xrandr -r 144
      xset -dpms
      xset r rate 250
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

  xdg.configFile."streamlink/config".text = ''
    default-stream=best
    hls-live-edge=1
    player=mpv --cache=no {filename}
    twitch-disable-hosting
  '';

  # Until Low Latency Twitch is merged into streamlink
  xdg.configFile."streamlink/plugins/twitch.py".source = ./patches/streamlink-twitch.py;

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
