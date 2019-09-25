# home.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [ ffmpeg file httpie p7zip ];

  home.sessionVariables = {
    PATH = "$PATH:$HOME/.local/bin";
    EDITOR = "nvim";

    BUNDLE_USER_CACHE = "$XDG_CACHE_HOME/bundle";
    BUNDLE_USER_CONFIG = "$XDG_CONFIG_HOME/bundle";
    BUNDLE_USER_PLUGIN = "$XDG_DATA_HOME/bundle";
    CARGO_HOME = "$XDG_DATA_HOME/cargo";
    GEM_HOME = "$XDG_DATA_HOME/gem";
    GEM_SPEC_CACHE = "$XDG_CACHE_HOME/gem";
    HTTPIE_CONFIG_DIR = "$XDG_CONFIG_HOME/httpie";
    LESSHISTFILE = "XDG_CACHE_HOME/less/history";
    LESSKEY = "$XDG_CONFIG_HOME/less/lesskey";
    NODE_REPL_HISTORY = "$XDG_DATA_HOME/node_repl_history";
    NPM_CONFIG_USERCONFIG = "$XDG_CONFIG_HOME/npm/npmrc";
    PGPASSFILE = "$XDG_CONFIG_HOME/pg/pgpass";
    PGSERVICEFILE = "$XDG_CONFIG_HOME/pg/pg_service.conf";
    PSQLRC = "$XDG_CONFIG_HOME/pg/psqlrc";
    PSQL_HISTORY = "$XDG_CACHE_HOME/pg/psql_history";
    PYTHON_EGG_CACHE = "$XDG_CACHE_HOME/python-eggs";
    RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
    STACK_ROOT = "$XDG_DATA_HOME/stack";
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    # TODO rust
  ];

  programs.bash = {
    enable = true;
    historyFile = "$XDG_CACHE_HOME/bash/history";
    shellAliases = {
      ls =
        "LC_COLLATE=C ls --classify --color=always --group-directories-first --si";
    };
  };

  programs.bat.enable = true;

  programs.broot.enable = true;

  programs.command-not-found.enable = true;

  # programs.direnv

  # programs.fzf.enable = true;

  programs.git = {
    enable = true;
    userEmail = "ldesgoui@gmail.com";
    userName = "ldesgoui";
  };

  programs.htop = { enable = true; };

  programs.jq.enable = true;

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ ale rust-vim vim-nix vim-vue ];
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

    configFile."npm/npmrc".text = ''
      prefix=$${XDG_DATA_HOME}/npm
      cache=$${XDG_CACHE_HOME}/npm
      tmp=$${XDG_RUNTIME_DIR}/npm
      init-module=$${XDG_CONFIG_HOME}/npm/config/npm-init.js
    '';
  };
}
