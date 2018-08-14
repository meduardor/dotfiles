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
"========= Git ===============
Plug 'tpope/vim-fugitive'
Plug 'motemen/git-vim'
Plug 'vimwiki/vimwiki'
"========= lang ==============
Plug 'pangloss/vim-javascript'
Plug 'vim-syntastic/syntastic'
call plug#end()
"========== Themes =====================
let g:airline_theme='minimalist'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
if (has("termguicolors"))
	set termguicolors
endif
colorscheme OceanicNext 
syntax enable
"set background=dark
"===========Airline ============
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1
"========================== Config =====================================
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
"======= Javascript ===========
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

