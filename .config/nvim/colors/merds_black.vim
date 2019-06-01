" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Maintainer:	Marco Eduardo <meduardo.r@protomail.com>
" Last Change:	24 May 2019

set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "merds_black"

hi Comment       ctermfg=22                   guifg=#000000
hi Constant      ctermfg=4      cterm=none    guifg=#00ffff	gui=none
hi Identifier    ctermfg=136    cterm=none    guifg=#00c0c0
hi Statement     ctermfg=124    cterm=none    guifg=#c0c000	gui=bold
hi PreProc       ctermfg=34                   guifg=#00ff00
hi Type          ctermfg=33                   guifg=#00c000
hi Special       ctermfg=36                   guifg=#0000ff
hi Error         ctermbg=9                    guibg=#ff0000
hi Todo          ctermfg=250    ctermbg=0     cterm=bold	guifg=#ff0000	guibg=#220000	gui=underline
hi Note          ctermfg=15     ctermbg=0     cterm=bold    	guifg=#ff0000 	guibg=#220000	gui=underline
hi Directory     ctermfg=2                    guifg=#00c000
hi StatusLine    ctermfg=3      ctermbg=8     cterm=none	guifg=#ffff00	guibg=#0000ff	gui=none
hi Normal        ctermfg=7                   guifg=#ffffff 	guibg=#000000
hi Search        ctermbg=3                    guibg=#c0c000
hi Operator      ctermfg=9                    guifg=#c0c000
hi Number        ctermfg=13                   guifg=#cccccc
