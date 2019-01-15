"============================== Global Settings =========================== 
 
set number
syntax enable
set relativenumber
set hidden
set encoding=utf-8
set nocompatible
filetype plugin on
filetype indent plugin on
set modeline
set ruler
set cursorline 
set wrapmargin=10
set textwidth=150
set sidescroll=5
set listchars+=precedes:<,extends:>
set wrap
set linebreak
set tabstop=8
set expandtab 
set shiftwidth=4
set softtabstop=4 
hi SpellBad cterm=underline ctermfg=DarkYellow ctermbg=none

map<F6> :set spell spelllang=en_us<CR>
map<F7> :setlocal spell! spelllang=pt<CR>

set foldmethod=expr
set foldexpr=MyFoldExpr(v:lnum)
    fun! MyFoldExpr(line)
        let str = getline(a:line)
        if str =~ '^sub\>'
            return '1'
        elseif str =~ '^}'
            return '<1'
        else
            return foldlevel(a:line - 1)
        endif
    endfun

augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=syntax | endif
augroup END



"================================ Plugin =============================
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'                                             "Syntax de varias linguagens
Plug 'terryma/vim-multiple-cursors'                                     "Seleção de múltiplas linhas 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }      "Navegação por arquivos 
Plug 'junegunn/fzf.vim'                                  
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'motemen/git-vim'
Plug 'vimwiki/vimwiki'
Plug 'pangloss/vim-javascript'
Plug 'vim-syntastic/syntastic'
Plug 'lervag/vimtex'
Plug 'Valloric/YouCompleteMe'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'farseer90718/vim-taskwarrior'
Plug 'majutsushi/tagbar'
Plug 'junegunn/goyo.vim'
call plug#end()


"================================ Javascript =========================
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

"============================ Atalhos =================================
"let mapleader="<\space>"                  "Tecla lider(espaço)
nnoremap <leader>; A;<esc>                 "Colocar (;) no final da linha de código
nnoremap <c-p> :Files<cr>
map <leader>c :w! \| !compiler <c-r>%<CR><CR>
map <leader>p :!saida <c-r>%<CR><CR>

"Split 
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"=============================Multiplecursors=========================
let g:multi_cursor_use_default_mapping=0

" Mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_start_key           = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

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

"============================ Themes/Arline ==========================
let g:gruvbox_bold = 1
let g:grubox_contrast_dark = 'hard'

let g:airline_powerline_fonts = 0
"let g:airline_symblos
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='monochrome'
"colorscheme gruvbox
"set background=dark
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
let g:vimtex_fold_enable = 1
let g:vimtex_fold_manual = 0 
let g:vimtex_fold_types ={
    \ 'preamble' : {'enabled' : 0},
    \ 'envs' : {
    \   'blacklist' : ['figure', 'table'],
    \},
    \}
let g:vimtex_indent_bib_enabled = 1
let g:vimtex_indent_enabled = 1
let g:vimtex_indent_conditionals = {
          \ 'open': '\v%(\\newif)@<!\\if%(field|name|numequal|thenelse)@!',
          \ 'else': '\\else\>',
          \ 'close': '\\fi\>',
          \}

let g:polyglot_disable = ['latex']

"============================== LaTeX Preview =======================
let g:livepreview_previewer = 'zathura'
let g:livepreview_engine = 'pdflatex'
let g:livepreview_cursorhold_recompile = 0
let g:Tex_ViewRule_pdf = 'zathura'
let g:Tex_ViewRuleComplete_pdf = 'zathura .tex/$1.pdf &'
"=================================== Completion ======================
let g:ycm_global_ycm_extra_conf = '$HOME/.vim/config_files/.ycm_extra_conf.py'
let g:ycm_auto_trigger = 1
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_windows_after_insertion = 1
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
set backspace=indent,eol,start 
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex =g:vimtex#re#youcompleteme

"============================= Tag Bar ===============================
nmap <F8> :TagbarToggle<CR>
"let g:tagbar_ctags_bin = '/usr/bin/ctgas' 

"Configurações VimWiki

let index_personal = {}
let index_personal.path = '~/MEGAsync/Notebooking/Personal'
let index_personal.syntax ='markdown'
let index_personal.ext = '.md'

let index_work = {}
let index_work.path = '~/MEGAsync/Notebooking/Work/'
let index_work.syntax = 'markdown'
let index_work.ext = '.md' 

let g:vimwiki_list = [{'path': '$HOME/.wiki', 'syntax': 'markdown', 'ext': '.md'}, {'path': '$HOME/.cheat', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'Rmd': 'markdown', 'rmd': 'markdown', '.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
autocmd BufRead,BufNewFile *.me, *.ms, *.mm, *.mom, *.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex


" Vim Goyo
"
nmap <F9> :Goyo \| set linebreak<CR>
