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

call plug#end()
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
colorscheme gruvbox
set background=dark

"========================== Config =====================================
set number 
set relativenumber 
set hidden 
set mouse=a 
set inccommand=split 

"============================ Atalhos =================================
let mapleader="\<space>"                  "Tecla lider(espaço)
nnoremap <leader>; A;<esc>                 "Colocar (;) no final da linha de código
nnoremap <c-p> :Files<cr> 

