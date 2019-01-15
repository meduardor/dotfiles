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
"================ Completion =========================================
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'xuhdev/vim-latex-live-preview', {'for': 'tex'}
Plug 'farseer90718/vim-taskwarrior'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'majutsushi/tagbar'
Plug 'tbabej/taskwiki'

"=============================== Git =================================
Plug 'tpope/vim-fugitive'
Plug 'motemen/git-vim'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'
"=============================== Lang ================================
Plug 'pangloss/vim-javascript'
Plug 'vim-syntastic/syntastic'
Plug 'lervag/vimtex'
call plug#end()
"=============================== Themes ==============================
let g:airline_theme='minimalist'
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
set ruler
set cursorline
set wrapmargin=10
set textwidth=150
set sidescroll=5
set listchars+=precedes:<,extends:>
set wrap
set linebreak
"syntax on 
set nocompatible
filetype plugin on
filetype indent plugin on
set modeline
set tabstop=8
set expandtab 
set shiftwidth=4
set softtabstop=4
map<F7> :setlocal spell! spelllang=pt<CR>
map<F6> :set spell spelllang=en_US<CR>
hi SpellBad cterm=underline guifg=Red guibg=none 
"================================ Javascript =========================
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

"============================ Atalhos =================================
nnoremap <leader>; A;<esc>                 "Colocar (;) no final da linha de código;
nnoremap <c-p> :Files<cr> 
map <leader>c :w! \| !compiler <c-r>%<CR><CR>
map <leader>p :!saida <c-r>%<CR><CR>

"Split
"
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"============================= Syntastic ===============================
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint', 'flake8', 'pep8', 'pycodestyle', 'pyflakes']
let g:syntastic_python_checkers = ['pyflakes_with_warnings']
let g:syntastic_tex_checkers = ['lacheck', 'text/language_check']
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
"================================ LaTex Preview =====================
let g:livepreview_previewer = 'mupdf'


"=================================== Completion ======================

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

let g:deoplete#sources#jedi#statement_length = 30
let g:deoplete#sources#jedi#enable_typeinfo = 1
let g:deoplete#sources#jedi#show_docstring = 1

let g:jedi#use_tabs_not_buffers = 1
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 1
let g:jedi#show_call_signatures = "1"
let g:jedi#completions_enabled = 1
let g:pymode_rope = 1
let g:jedi#completions_enabled = 0


"============================= Tag Bar =================================
nmap <F8> :TagbarToggle<CR>

"========================= Task Wiki ======================================

let g:task_rc_override = 'rc.defaultwidth=0'
let g:task_rc_override = 'rc.defaultheight=0'
let g:task_report_name = 'next'
let g:task_report_command = []
let g:task_highlight_field = 1
let g:task_readonly = 0
let g:task_gui_term = 1
let g:task_rc_override = 'rc.defaultwidth=999'
let g:task_default_prompt = ['due', 'description']
let g:task_info_vsplit = 0
let g:task_info_size = 15
let g:task_info_position = 'belowright'
let g:task_log_directory = '~/.task'
let g:task_log_max = '20'
let g:task_left_arrow = ' <<'
let g:task_left_arrow = '>> '


"Configurações VimWiki

let index_personal = {}
let index_personal.path = '~/MEGAsync/Notebooking/Personal/'
let index_personal.syntax ='markdown'
let index_personal.ext = '.md'

"""
let index_work = {}
let index_work.path = '~/MEGAsync/Notebooking/Work/'
let index_work.syntax = 'markdown'
let index_work.ext = '.md' 

"""
let g:vimwiki_list = [{'path': '$HOME/.wiki', 'syntax': 'markdown', 'ext': '.md'}, {'path': '$HOME/.cheat', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown', '.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
autocmd BufRead,BufNewFile *.me, *.ms, *.mm, *.man, *.mom set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex

" Snippets - python; javascript; LaTex

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"""
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips'
let g:UltiSnipsEditSplit="vertical"
nmap<F5> :UltiSnipsEdit<CR>

"Vim GOYO
"
nmap <F9> :Goyo \| set linebreak<CR>

