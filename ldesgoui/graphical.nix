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

  home.packages = with pkgs; [
    dmenu
    gimp
    maim
    mumble_git
    pavucontrol
    st-custom
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

  programs.feh.enable = true;

  programs.firefox = {
    enable = true;
  };

  programs.mpv.enable = true;

  programs.zathura.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    st-custom =
      pkgs.st.override {
        patches = [
          ./patches/st-fps1001.diff

          (
            pkgs.writeText "st-font.diff"
              (
                builtins.replaceStrings [ "FONT" ] [ font ]
                  (builtins.readFile ./patches/st-font.diff)
              )
          )
        ] ++ builtins.map pkgs.fetchurl [
          {
            url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.8.2.diff";
            sha256 = "9c5aedce2ff191437bdb78aa70894c3c91a47e1be48465286f42d046677fd166";
          }

          {
            url = "https://st.suckless.org/patches/scrollback/st-scrollback-mouse-0.8.2.diff";
            sha256 = "6103a650f62b5d07672eee9e01e3f4062525083da6ba063e139ca7d9fd58a1ba";
          }

          {
            url = "https://st.suckless.org/patches/dracula/st-dracula-0.8.2.diff";
            sha256 = "5eb8e0375fda9373c3b16cabe2879027300e73e48dbd9782e54ffd859e84fb7e";
          }
        ];
      };
  };


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
    default-stream=480p60,480p,720p60,720p,best
    hls-live-edge=1
    player=mpv --cache=no {filename}
    twitch-disable-hosting
    twitch-oauth-token=r6bzi0k4z0eurlmj6pyk44qytfsaq0
  '';

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
