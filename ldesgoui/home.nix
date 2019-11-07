# home.nix
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    exa
    fd
    ffmpeg
    file
    httpie
    nixpkgs-fmt
    p7zip
    ripgrep
    youtube-dl
  ];

  home.sessionVariables = {
    PATH = "$PATH:$HOME/.local/bin";
    EDITOR = "nvim";

    BUNDLE_USER_CACHE = "${config.xdg.cacheHome}/bundle";
    BUNDLE_USER_CONFIG = "${config.xdg.configHome}/bundle";
    BUNDLE_USER_PLUGIN = "${config.xdg.dataHome}/bundle";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    GEM_HOME = "${config.xdg.dataHome}/gem";
    GEM_SPEC_CACHE = "${config.xdg.cacheHome}/gem";
    HTTPIE_CONFIG_DIR = "${config.xdg.configHome}/httpie";
    INPUTRC = "${config.xdg.configHome}/readline/inputrc";
    LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
    LESSKEY = "${config.xdg.configHome}/less/lesskey";
    NODE_REPL_HISTORY = "${config.xdg.cacheHome}/node_repl_history";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    PGPASSFILE = "${config.xdg.configHome}/pg/pgpass";
    PGSERVICEFILE = "${config.xdg.configHome}/pg/pg_service.conf";
    PSQLRC = "${config.xdg.configHome}/pg/psqlrc";
    PSQL_HISTORY = "${config.xdg.cacheHome}/pg/psql_history";
    PYTHON_EGG_CACHE = "${config.xdg.cacheHome}/python-eggs";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    SQLITE_HISTORY = "${config.xdg.cacheHome}/sqlite_history";
    STACK_ROOT = "${config.xdg.dataHome}/stack";
  };

  nixpkgs.config.allowUnfree = true;

  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" "ignoredups" "ignorespace" ];
    historyFile = "${config.xdg.cacheHome}/bash/history";
    sessionVariables = { PROMPT_COMMAND = "history -a"; };
    shellAliases = {
      ls = "exa -F --group-directories-first";
      ll = "ls -lh --git";
      la = "ll -a";
      l = "la";
      lt = "ll -T";
      cat = "bat";
    };
  };

  programs.bat.enable = true;

  programs.command-not-found.enable = true;

  programs.direnv.enable = true;

  programs.fzf.enable = true;

  programs.git = {
    enable = true;
    userEmail = "ldesgoui@gmail.com";
    userName = "ldesgoui";
  };

  programs.htop = {
    enable = true;
    delay = 2;
    fields = [ "PID" "USER" "PERCENT_CPU" "PERCENT_MEM" "TIME" "COMM" ];
    hideThreads = true;
    hideUserlandThreads = true;
    highlightBaseName = true;
    shadowOtherUsers = true;
    showProgramPath = false;
    treeView = true;
  };

  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      ale
      vim-commentary
      vim-polyglot
      vim-sensible
      vim-surround
      vim-repeat
    ];
    extraConfig = builtins.readFile ./neovim.vim;
    viAlias = true;
    vimAlias = true;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      pi = { hostname = "10.0.0.1"; };
      desktop = { hostname = "10.0.0.2"; };
      nacl = {
        hostname = "68.183.50.247";
        port = 60022;
        user = "citadel";
        extraOptions.strictHostKeyChecking = "no";
      };
    };
  };

  xdg = {
    enable = true;
  };

  xdg.configFile."npm/npmrc".text = ''
    prefix=''${XDG_DATA_HOME}/npm
    cache=''${XDG_CACHE_HOME}/npm
    tmp=''${XDG_RUNTIME_DIR}/npm
    init-module=''${XDG_CONFIG_HOME}/npm/config/npm-init.js
  '';

  xdg.configFile."readline/inputrc".text = ''
    $include /etc/inputrc
    set enable-keypad on
  '';
}
