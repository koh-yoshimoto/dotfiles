exists('g:vscode')

" display filename
set title

" encoding
set encoding=UTF-8
scriptencoding utf-8
set fenc=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
lang en_US.UTF-8

" display row number
set number
" hilight current row
set cursorline

set wrap
" テキスト背景色
au ColorScheme * hi Normal ctermbg=none
" 括弧対応
au ColorScheme * hi MatchParen cterm=bold ctermfg=214 ctermbg=black
" スペルチェック
au Colorscheme * hi SpellBad ctermfg=23 cterm=none ctermbg=none
" visualize bell
set visualbell t_vb=
" display control char
set list

" indent
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smarttab

" search
set hlsearch
set incsearch
set ignorecase
set smartcase
set nowrapscan
set gdefault

" command completion
set wildmode=list:longest,full
set showcmd

" use clipboard
set clipboard=unnamed,autoselect

set whichwrap=b,s,h,l,<,>,~,[,]

source $VIMRUNTIME/macros/matchit.vim

set display=lastline

set hidden

" specify a backfile folder
set backupdir=$HOME/.vim/backup
" specify a uploadfile folder
set undodir=$HOME/.vim/backup
" do not create swapfile
set noswapfile

" use mouse
set mouse=a

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <down> gj
nnoremap <up> gk

nmap <silent> <C-k> :bnext<CR>
nmap <silent> <C-j> :bprev<CR>

inoremap <silent> jj <esc>

nnoremap Y y$

" remove highlights
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" term
if has('nvim')
  command! -nargs=* Term split | wincmd p | resize 12 | terminal <args>
  command! -nargs=* Termv vsplit | wincmd p | vertical resize 30 | terminal <args>
  nnoremap <C-@> :Term<CR>
endif

tnoremap <silent> jj <C-\><C-n>

" leader key settings
let mapleader = "\<Space>"

" save file
nnoremap <Leader>w :w<CR>

" quit file
nnoremap <Leader>q :q<CR>

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" prevent indentation collapse when pasting
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"dein scripts-----------------------------
if &compatible
  set nocompatible
endif

" set up the dein.vim directory
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:config_dir = expand('~/.config/nvim/dein')

" automatic installation of dein.vim
if !isdirectory(s:dein_repo_dir)
  execute '!git clone <https://github.com/Shougo/dein.vim>' s:dein_repo_dir
endif
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:toml      = g:config_dir . '/dein.toml'
  let s:lazy_toml = g:config_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

"end dein scripts-------------------------

let g:python3_host_prog="/usr/bin/python3"

" colorsheme
colorscheme gruvbox-material
let g:airline_theme = 'badwolf'


" rust
let g:rustfmt_autosave = 1

" LSP
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <C-]> <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer> <Leader>d <plug>(lsp-type-definition)
  nmap <buffer> <Leader>r <plug>(lsp-references)
  nmap <buffer> <Leader>i <plug>(lsp-implementation)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
" let g:asyncomplete_auto_popup = 1
" let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1
let g:lsp_preview_float = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_settings_filetype_go = ['gopls', 'golangci-lint-langserver']

let g:lsp_settings = {}
let g:lsp_settings['gopls'] = {
  \  'workspace_config': {
  \    'usePlaceholders': v:true,
  \    'analyses': {
  \      'fillstruct': v:true,
  \    },
  \  },
  \  'initialization_options': {
  \    'usePlaceholders': v:true,
  \    'analyses': {
  \      'fillstruct': v:true,
  \    },
  \  },
  \}

" For snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

set completeopt+=menuone
