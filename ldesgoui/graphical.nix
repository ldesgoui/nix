# graphical.nix
{ pkgs, config, ... }:
let
  font = {
    family =
      # "Andale Mono"
      # "Anonymous Pro"
      # "Cascadia Code"
      # "Cousine"
      # "Cozette"
      ## "Cutive Mono"
      # "DejaVu Sans Mono"
      # "Fantasque Sans Mono"
      "Fira Mono"
      # "Hack"
      # "IBM Plex Mono"
      # "Inconsolata"
      # "Iosevka"
      # "Iosevka Fira"
      # "NovaMono"
      # "PT Mono"
      # "Source Code Pro"
      # "Space Mono"
      # "Ubuntu Mono"
      # "Victor Mono"
    ;
    size = 11;
  };
in
{
  imports = [ ./home.nix ];

  fonts.fontconfig.enable = true;

  gtk = {
    enable = true;
    font.name = "${font.family} ${font.size}";
    theme = {
      package = pkgs.stilo-themes;
      name = "Stilo-dark";
    };
  };

  home.keyboard.options = [
    "compose:ralt"
  ];

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
    cozette
    emojione
    fantasque-sans-mono
    google-fonts
    hack-font
    iosevka
    iosevka-fira
    victor-mono
  ];

  home.sessionVariables = {
    GIT_ASKPASS = "";
    ICEAUTHORITY = "${config.xdg.cacheHome}/ICEauthority";
    # XAUTHORITY = "\${XDG_RUNTIME_DIR:-/run/user/\$(id -u)}/Xauthority"; # breaks stuff
    XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
    XCOMPOSEFILE = "${config.xdg.configHome}/X11/xcompose";
  };

  nixpkgs.overlays = [
    (
      self: super: {
        chatterino2 = super.libsForQt5.callPackage ./packages/chatterino2.nix { };

        iosevka-fira = super.iosevka.override {
          set = "fira";
          privateBuildPlan = {
            family = "Iosevka Fira";
            design = [ "ss05" ];
          };
        };
      }
    )
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font = { normal.family = font.family; size = font.size; };
      selection.save_to_clipboard = true;
      window.padding = { x = 4; y = 4; };
    };
  };

  programs.feh.enable = true;

  programs.firefox.enable = true;

  programs.mpv = {
    enable = true;

    bindings = {
      "Alt+-" = "add video-zoom -0.1";
      "Alt+=" = "add video-zoom 0.1";
      "Alt+UP" = "add video-pan-y 0.01";
      "Alt+DOWN" = "add video-pan-y -0.01";
      "Alt+LEFT" = "add video-pan-x 0.01";
      "Alt+RIGHT" = "add video-pan-x -0.01";
      "Alt+BS" = "set video-zoom 0; set video-pan-x 0; set video-pan-y 0";
    };

    config = {
      input-default-bindings = false;
    };
  };

  programs.zathura.enable = true;

  services.dunst = {
    enable = true;
    settings.global = {
      geometry = "0x5-20+20";
      font = "${font} ${font.size}";
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
    hls-segment-stream-data
    player=mpv -af=lavfi=[dynaudnorm=f=10] --cache=no {filename}
    twitch-disable-ads
    twitch-disable-hosting
    twitch-disable-reruns
    twitch-low-latency
  '';

  # https://github.com/rycee/home-manager/pull/510
  xdg.dataFile."dbus-1/services/ca.desrt.dconf.service".source =
    "${pkgs.gnome3.dconf}/share/dbus-1/services/ca.desrt.dconf.service";

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
