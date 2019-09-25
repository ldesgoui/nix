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
