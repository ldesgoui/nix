set expandtab       " tabs are spaces
set hidden          " keep buffers alive when hidden
set lazyredraw      " don't redraw when executing macros
set nomodeline      " disable modeline
set number          " show absolute line number
set relativenumber  " show relative line numbers
set shiftwidth=4    " how many spaces is >>
set softtabstop=4   " how many spaces is <TAB> in insert
set tabstop=4       " width of a tab

" per filetype settings
autocmd FileType html       setlocal sw=2 sts=2 ts=2
autocmd FileType javascript setlocal sw=2 sts=2 ts=2
autocmd FileType json       setlocal sw=2 sts=2 ts=2
autocmd FileType vue        setlocal sw=2 sts=2 ts=2

" make the matching paren less obnoxious
highlight MatchParen ctermbg=none ctermfg=red

let mapleader=","

nnoremap ;          :
nnoremap <C-J>      :bnext<CR>
nnoremap <C-K>      :bprev<CR>
nnoremap <F1>       <Nop>
nnoremap Q          <Nop>
vnoremap <leader>s  :!LC_ALL=C sort<CR>

" Ale
let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = "never"

let g:ale_javascript_eslint_executable = "npx eslint"
let g:ale_javascript_prettier_executable = "npx prettier"

let g:ale_rust_cargo_use_clippy = 1

let g:ale_fixers            = { "*": ["remove_trailing_lines", "trim_whitespace"] }
let g:ale_fixers.css        = ["prettier"]
let g:ale_fixers.elm        = ["elm-format"]
let g:ale_fixers.graphql    = ["prettier"]
let g:ale_fixers.html       = ["prettier"]
let g:ale_fixers.javascript = ["eslint", "prettier"]
let g:ale_fixers.json5      = ["prettier"]
let g:ale_fixers.less       = ["prettier"]
let g:ale_fixers.markdown   = ["prettier"]
let g:ale_fixers.nix        = ["nixpkgs-fmt"]
let g:ale_fixers.python     = ["black"]
let g:ale_fixers.ruby       = ["rubocop"]
let g:ale_fixers.rust       = ["rustfmt"]
let g:ale_fixers.scss       = ["prettier"]
let g:ale_fixers.sh         = ["shfmt"]
let g:ale_fixers.sql        = ["sqlformat"]
let g:ale_fixers.typescript = ["eslint", "prettier"]
let g:ale_fixers.vue        = ["prettier"]
let g:ale_fixers.yaml       = ["prettier"]
