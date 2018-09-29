"============================== Global Settings {{{
 
set number
syntax enable
set relativenumber
set hidden
set encoding=utf-8
set nocompatible
filetype plugin on
filetype indent plugin on
set modeline
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

"}}}

"================================ Plugin =============================
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'                                             "Syntax de varias linguagens
Plug 'terryma/vim-multiple-cursors'                                     "Seleção de múltiplas linhas 
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }      "Navegação por arquivos 
Plug 'junegunn/fzf.vim'                                  
"Plug 'Shougo/deoplete.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
Plug 'tpope/vim-fugitive'
Plug 'motemen/git-vim'
Plug 'vimwiki/vimwiki'
Plug 'pangloss/vim-javascript'
Plug 'vim-syntastic/syntastic'
Plug 'lervag/vimtex'
Plug 'Valloric/YouCompleteMe'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
"Plug 'tbabej/taskwiki'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'farseer90718/vim-taskwarrior'
Plug 'majutsushi/tagbar' 
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
let mapleader="<space>"                  "Tecla lider(espaço)
nnoremap <leader>; A;<esc>                 "Colocar (;) no final da linha de código
nnoremap <c-p> :Files<cr>
"=============================Multiplecursors=========================
let g:multi_cursor_use_default_mapping=0

" Default mapping
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
let g:livepreview_previewer = 'mupdf'


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


