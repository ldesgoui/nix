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

    extraConfig = ''
      set nocompatible
      set expandtab
      set ruler
      set rulerformat=line\ %l\ char\ %c
      set hidden
      set tabstop=4
      set shiftwidth=4
      set mouse=""
      set list
      set listchars=tab:_\ ,trail:~

      let mapleader=","

      vnoremap <leader>s :!LC_ALL=C sort<CR>
      nnoremap <C-J> :bn<CR>
      nnoremap <C-K> :bp<CR>
      map Q <Nop>

      let g:ale_fix_on_save = 1
      let g:ale_lint_on_enter = 0
      let g:ale_lint_on_insert_leave = 0
      let g:ale_lint_on_text_changed = 'never'

      let g:ale_javascript_prettier_executable = "npx prettier"

      let g:ale_rust_cargo_use_clippy = 1

      let g:ale_fixers = {
      \    '*': ['remove_trailing_lines', 'trim_whitespace'],
      \}
    '';

    viAlias = true;
    vimAlias = true;
  };

  # programs.ssh = {
  #   enable = true;
  # };

  xdg = { enable = true; };
}
