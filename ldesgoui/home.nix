# home.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [ ffmpeg file httpie p7zip ];

  home.sessionVariables = {
    PATH = "$PATH:$HOME/.local/bin";
    EDITOR = "nvim";
    LESSHISTFILE = "/dev/null";
    # PROMPT_COMMAND = "history -a";
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    # TODO rust
  ];

  programs.bash = {
    enable = true;
    historyFile = "$HOME/.cache/bash/history";
    shellAliases = {
      ls =
        "LC_COLLATE=C ls --classify --color=always --group-directories-first --si";
    };
    shellOptions = [ ];
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

  # programs.ssh = {
  #   enable = true;
  # };

  xdg = { enable = true; };
}
