set expandtab " tabs are spaces
set hidden " keep buffers alive when hidden
set lazyredraw " don't redraw when executing macros
set nomodeline " disable modeline
set nowrap " disable line wrap
set number " show line numbers
set shiftwidth=4 " how many spaces is >>
set softtabstop=4 " how many spaces is <TAB> in insert
set tabstop=4 " width of a tab

" per filetype settings
autocmd FileType html setlocal sw=2 sts=2 ts=2
autocmd FileType javascript setlocal sw=2 sts=2 ts=2
autocmd FileType json setlocal sw=2 sts=2 ts=2
autocmd FileType vue setlocal sw=2 sts=2 ts=2

" make the matching paren less obnoxious
highlight MatchParen ctermbg=none ctermfg=red

let mapleader=","

nnoremap ; :
nnoremap <C-J> :bnext<CR>
nnoremap <C-K> :bprev<CR>
nnoremap <F1> <Nop>
nnoremap Q <Nop>
vnoremap <leader>s :!LC_ALL=C sort<CR>

let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = "never"

let g:ale_javascript_eslin_executable = "npx eslint"
let g:ale_javascript_prettier_executable = "npx prettier"

let g:ale_rust_cargo_use_clippy = 1

let g:ale_fixers = {
\   "*": ["remove_trailing_lines", "trim_whitespace"],
\   "css": ["prettier"],
\   "elm": ["elm-format"],
\   "graphql": ["prettier"],
\   "html": ["prettier"],
\   "javascript": ["eslint", "prettier"],
\   "json5": ["prettier"],
\   "less": ["prettier"],
\   "markdown": ["prettier"],
\   "python": ["black"],
\   "ruby": ["rubocop"],
\   "rust": ["rustfmt"],
\   "scss": ["prettier"],
\   "sh": ["shfmt"],
\   "sql": ["sqlformat"],
\   "typescript": ["eslint", "prettier"],
\   "vue": ["prettier"],
\   "yaml": ["prettier"],
\}
