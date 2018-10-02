"============================= Plug =================================
call plug#begin()

Plug 'jiangmiao/auto-pairs'                                             "completion parents
Plug 'morhetz/gruvbox'                                                  "Tema 
Plug 'sheerun/vim-polyglot'                                             "Syntax de varias linguagens
Plug 'terryma/vim-multiple-cursors'                                     "Seleção de multiplas linhas 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }      "Navegação por arquivos 
Plug 'junegunn/fzf.vim'                                                 " //    //
"Plug 'roxma/nvim-completion-manager'                                    "auto completion 
Plug 'w0rp/ale'                                                         "Lint
Plug 'cohama/lexima.vim'                                                 
Plug 'SirVer/ultisnips'                                                 "UltiSnipsEditSplit
Plug 'honza/vim-snippets'                                               "sinnepts
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-powerline'
Plug 'mhartington/oceanic-next'
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
"=============================== Git =================================
Plug 'tpope/vim-fugitive'
Plug 'motemen/git-vim'
Plug 'vimwiki/vimwiki'
"=============================== Lang ================================
Plug 'pangloss/vim-javascript'
Plug 'vim-syntastic/syntastic'
Plug 'lervag/vimtex'
call plug#end()
"=============================== Themes ==============================
let g:airline_theme='minimalist'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
if (has("termguicolors"))
    set termguicolors
endif
"colorscheme OceanicNext 
syntax enable
set background=dark
colorscheme PaperColor 
"color dracula
"================================ Airline ============================
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=0
"=============================== Config ==============================
set number 
set relativenumber 
set hidden 
set mouse=a 
set inccommand=split 
set encoding=utf-8
syntax on 
set nocompatible
filetype plugin on
filetype indent plugin on
set modeline
set tabstop=8
set expandtab 
set shiftwidth=4
set softtabstop=4
"================================ Javascript =========================
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

"============================ Atalhos =================================
let mapleader="\<space>"                  "Tecla lider(espaço)
nnoremap <leader>; A;<esc>                 "Colocar (;) no final da linha de código
nnoremap <c-p> :Files<cr> 
"============================= Syntastic ===============================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_checkers = ['pyflakes_with_warnings']
let g:syntastic_tex_checkers = ['lacheck', 'text/language_check']

autocmd FileType javascript let b:syntastic_javascript_jscs_args =
    \ get(g:, 'syntastic_javascript_jscs_args', '') .
    \ FindConfig('-c', '.jscsrc', expand('<afile>:p:h', 1))
"============================ VimTeX =================================

let g:matchup_override_vimtex = 1
let g:vimtex_enabled = 1
let g:vimtex_compiler_enabled = 1
let g:vimtex_compiler_arara = {
\ 'background' : 1,
\}
let g:vimtex_complete_enabled = 1
let g:vintex_syntax_enabled = 1
let g:vimtex_syntax_minted = [
\ {
\ 	'lang' : 'c',
\ },
\ { 
\	'lang' : 'cpp',
\	'environments' : ['cppcode', 'cppcode_test'],
\ },
\ {
\	'lang' : 'python',
\	'ignore' : [
\	  'pythonEscape',
\	  'pythonBEscape',
\	  ],
\ }
\]	
let g:vimtex_view_enabled = 1
let g:vimtex_view_automatic = 1 
let g:vimtex_view_method = 'mupdf'
let g:vimtex_viewer_mupdf = 1 
let g:vimtex_view_mupdf_options = 1 
let g:vimtex_complete_enabled = 1
let g:vimtex_complete_close_braces = 1 
let g:vimtex_complete_recursive_bib = 1
let g:vimtex_indent_enabled = 1
let g:vimtex_indent_bib_enabled = 1

"=================================== Completion ======================

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
