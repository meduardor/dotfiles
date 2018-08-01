"============================= Plug =================================
call plug#begin()

Plug 'jiangmiao/auto-pairs'                                             "completion parents
Plug 'morhetz/gruvbox'                                                  "Tema 
Plug 'sheerun/vim-polyglot'                                             "Syntax de varias linguagens
Plug 'terryma/vim-multiple-cursors'                                     "Seleção de multiplas linhas 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }      "Navegação por arquivos 
Plug 'junegunn/fzf.vim'                                                 " //    //
Plug 'roxma/nvim-completion-manager'                                    "auto completion 
Plug 'w0rp/ale'                                                         "Lint
Plug 'cohama/lexima.vim'                                                 
Plug 'SirVer/ultisnips'                                                 "UltiSnipsEditSplit
Plug 'honza/vim-snippets'                                               "sinnepts
"Plug 'gmarik/Vundle.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'bling/vim-bufferline'
Plug 'Lokaltog/vim-powerline'
"Plug 'scrooloose/nerdtree'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"========= Git ===============
Plug 'tpope/vim-fugitive'
Plug 'motemen/git-vim'

"========= lang ==============
Plug 'pangloss/vim-javascript'
call plug#end()

let g:airline_theme='badwolf'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
colorscheme gruvbox
set background=dark
"===========Airline ============
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline_theme='badwolf'
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1
"let g:airline_solarized_bg='dark'
"========================== Config =====================================
set number 
set relativenumber 
set hidden 
set mouse=a 
set inccommand=split 
set encoding=utf-8
syntax on 
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
"============================= Nerdtree ========================
let NERDTreeWinSize=30
autocmd VimEnter * if !argc() | NERDTree | endif 
nmap " :NERDTreetoggle<CR>
let NERDtreeShowHidden=1


