
set-face global delimiter rgb:aa3a03,default

hook global WinCreate .* %{
        try %{
            add-highlighter buffer/numbers          number-lines -relative -hlcursor -separator ' '
            add-highlighter buffer/matching         show-matching
            add-highlighter buffer/wrap             wrap -word -indent -marker '↪'
            add-highlighter buffer/show-whitespaces show-whitespaces -lf ' ' -spc ' ' -nbsp '⋅'
            add-highlighter buffer/operators        regex (\+|-|\*|&|=|\\|\?|%|\|-|!|\||->|\.|,|<|>|:|\^|/|~) 0:operator
            add-highlighter buffer/delimiters       regex (\(|\)|\[|\]|\{|\}|\;|'|`) 0:delimiter
        }
}


## indentation
set-option global tabstop     4
set-option global indentwidth 4

## keep space around cursor
set-option global scrolloff 10,10

## save on pressing enter
map global normal <ret> ": w<ret>"

## remap grep-jump
map global goto <ret> "<esc><ret>"

# vim old habits
map global normal D '<a-l>d' -docstring 'delete to end of line'
map global normal Y '<a-l>y' -docstring 'yank to end of line'
map global normal <a-h> Gi

# # case insensitive search
map global prompt <a-i> "<home>(?i)<end>"

# calculate
map global normal = '|calc<ret>'

# Movement mode (depends on case.kak)
map global user m -docstring "case based movement" ': enter-user-mode movecase<ret>'

## user mappings
map global user l -docstring 'lsp' ': enter-user-mode lsp<ret>'

## clipboard interaction
map global user p -docstring 'paste from clipboard' '!xsel -bo<ret>uU'
map global user y -docstring 'copy to clipboard' '<a-|>xsel -bi<ret>'
map global user d -docstring 'cut to clipboard' '|xsel -bi<ret>'

## comment lines
map global user c -docstring 'toggle comment lines' %{_: try comment-block catch comment-line<ret>}

## tabs to spaces
hook global InsertChar \t %{
 	exec -draft h@
}


# Delete buffer and quit
map global normal <c-q> ":db;q<ret>"

  # file types
hook global BufCreate .*\.xsd %{ set buffer filetype xml }

declare-option str language pt-BR

# XML tags

map -docstring "xml tag object" global object t %{c<lt>([\w.]+)\b[^>]*?(?<lt>!/)>,<lt>/([\w.]+)\b[^>]*?(?<lt>!/)><ret>}

## modeline
set-option global modelinefmt %{{Error}%sh{[ $kak_opt_lsp_diagnostic_error_count -gt 0 ] && echo "$kak_opt_lsp_diagnostic_error_count"}{Default} %val{bufname} %val{cursor_line}:%val{cursor_char_column} {{context_info}} {{mode_info}} - %val{client}@[%val{session}]}

# Plugins

source "%val{config}/plugins/plug.kak/rc/plug.kak"

plug "andreyorst/plug.kak" noload
plug "andreyorst/fzf.kak" %{
    map -docstring 'fzf mode' global normal '<c-p>' ': fzf-mode<ret>'
} defer fzf %{
    set-option global fzf_preview_width '65%'
    set-option global fzf_project_use_tilda true
    evaluate-commands %sh{
        if [ -n "$(command -v fd)" ]; then
            echo "set-option global fzf_file_command %{fd . --no-ignore --type f --follow --hidden --exclude .git --exclude .svn}"
        else
            echo "set-option global fzf_file_command %{find . \( -path '*/.svn*' -o -path '*/.git*' \) -prune -o -type f -follow -print}"
        fi
        [ -n "$(command -v bat)" ] && echo "set-option global fzf_highlight_cmd bat"
        [ -n "${kak_opt_grepcmd}" ] && echo "set-option global fzf_sk_grep_command %{${kak_opt_grepcmd}}"
     }
}

plug "occivink/kakoune-phantom-selection" %{
    declare-user-mode phantom-selection
    map global user h -docstring "Phantom selections" ": enter-user-mode phantom-selection<ret>"
    map global phantom-selection n -docstring "Next" ": phantom-sel-iterate-next<ret>"
    map global phantom-selection p -docstring "Previous" ": phantom-sel-iterate-prev<ret>"
    map global phantom-selection c -docstring "Clear" ": phantom-sel-select-all; phantom-sel-clear<ret>"
    map global phantom-selection a -docstring "Add" ": phantom-sel-add-selection<ret>"
}


plug "occivink/kakoune-snippets"  config %{
    set-option global snippets_auto_expand false
    declare-user-mode snippets
    map global user s -docstring "Snippets" ": enter-user-mode snippets<ret>"
    map global snippets n -docstring "Select next placeholder" ": snippets-select-next-placeholders<ret>"
    map global snippets s -docstring "Snippet" ": snippets "
    map global snippets i -docstring "Info" ": snippets-info<ret>"
    map global insert <a-e> "<esc>: try snippets-select-next-placeholders catch phantom-sel-iterate-next<ret>i"
    add-highlighter global/ ranges snippets_placeholders
    set-option global snippets_directories "%opt{plug_install_dir}/kakoune-snippet-collection/snippets"
    source "%val{config}/snippets.kak"
}

plug "andreyorst/kakoune-snippet-collection"

plug "occivink/kakoune-sudo-write"

plug "jjk96/kakoune-fireplace"

plug "lenormf/kakoune-extra" load %{
        syntastic.kak
}

plug "alexherbo2/yank-ring.kak" %{
    map global normal <c-p> ':<space>yank-ring<ret><c-p>'
    map global normal <c-n> ':<space>yank-ring<ret><c-n>'
}

plug "Delapouite/kakoune-buffers" %{
    map global user b ': enter-user-mode -lock buffers<ret>'   -docstring 'buffers (lock)…'
}

plug "ul/kak-tree" %{
    declare-user-mode tree
    map global tree u ': tree-select-parent-node<ret>' -docstring 'parent'
    map global tree n ': tree-select-next-node<ret>' -docstring 'next'
    map global tree p ': tree-select-previous-node<ret>' -docstring 'previous'
    map global tree c ': tree-select-children<ret>' -docstring 'children'
    map global tree f ': tree-select-first-child<ret>' -docstring 'first child'
    map global tree t ': tree-node-sexp<ret>' -docstring 'show syntax tree'
    map global tree . ': enter-user-mode -lock tree<ret>' -docstring 'lock'
    map global user t ': enter-user-mode tree<ret>' -docstring 'tree-sitter'
}

plug 'delapouite/kakoune-cd' %{
    # Suggested aliases
    alias global cdb change-directory-current-buffer
    alias global cdr change-directory-project-root
    alias global ecd edit-current-buffer-directory
    alias global pwd print-working-directory
}

plug 'Delapouite/kakoune-mirror' %{
    map global user o -docstring 'mirror' ': enter-user-mode mirror<ret>'
    map global mirror * -docstring 'stars (markdown bold)' 'i**<esc>a**<esc>'
    map global mirror . ': enter-user-mode -lock mirror<ret>'
}

plug 'alexherbo2/split-object.kak' %{
    map global normal <a-L> ': enter-user-mode split-object<ret>'
}



plug "ul/kak-lsp" do %{
    cargo build --release --locked
    cargo install --force --path .
    }config %{
        define-command lsp-restart %{ lsp-stop; lsp-start }
        set-option global lsp_completion_trigger "execute-keys 'h<a-h><a-k>\S[^\s,=;*(){}\[\]]\z<ret>'"
        set-option global lsp_diagnostic_line_error_sign "!"
        set-option global lsp_diagnostic_line_warning_sign "?"
        hook global WinSetOption filetype=(c|cpp|rust) %{
            map window user "l" ": enter-user-mode lsp<ret>" -docstring "LSP mode"
            lsp-enable-window
            lsp-auto-hover-enable
            lsp-auto-hover-insert-mode-disable
            set-option window lsp_hover_anchor true
            set-face window DiagnosticError default+u
            set-face window DiagnosticWarning default+u
        }
        hook global WinSetOption filetype=rust %{
            set-option window lsp_server_configuration rust.clippy_preference="on"
        }
        hook global KakEnd .* lsp-exit
        } else %{
        hook global WinSetOption filetype=(c|cpp) %{
            clang-enable-autocomplete
            clang-enable-diagnostics
            hook window BufWritePre .* %{ clang-parse }
            alias window lint clang-parse
            set-option -add window clang_options %sh{ (
                while [ "$PWD" != "$HOME" ]; do
                    if [ -e "$PWD/compile_flags.txt" ]; then
                        printf "%s\n" "$(cat "$PWD/compile_flags.txt" | tr '\n' ' ')"
                        exit
                     fi
                     cd ..
                done
           ) }
           map -docstring "next diagnostics error" window goto n '<esc>: clang-diagnostics-next<ret>'
        }
        hook global WinSetOption filetype=rust) %{
            racer-enable-autocomplete
            map -docstring "go to definition" window goto d '<esc>: racer-go-definition<ret>'
       }
}

#plug "andreyorst/powerline.kak" defer powerline %{
#    powerline-separator none
#    set-option global powerline_ignore_warnings true
#    set-option global powerline_format 'git bufname langmap smarttab mode_info filetype client session position'
#    powerline-toggle line_column off
# }
 

plug "andreyorst/smarttab.kak" %{
    set-option global softtabstop 4
    hook global WinSetOption filetype=(rust|markdown|kak|lisp|scheme|sh|perl) expandtab
    hook global WinSetOption filetype=(makefile|gas) noexpandtab
    hook global WinSetOption filetype=(c|cpp) smarttab
 }

plug "alexherbo2/auto-pairs.kak" %{
    map global user 's' ': auto-pairs-surround<ret>' -docstring "surround selection"
 }

plug "alexherbo2/replace.kak" config %{
    map global user r -docstring 'Replace mode' ':<space>replace<ret>'
 }


plug "alexherbo2/move-line.kak" config %{
    map global normal '<a-up>'   ': move-line-above %val{count}<ret>'
    map global normal '<a-down>' ': move-line-below %val{count}<ret>'
}


#Colorscheme
colorscheme merds_black  
#plug "andreyorst/base16-gruvbox.kak" theme %{
#	colorscheme base16-gruvbox-dark-hard
#}

############################################################### Language

hook global WinSetOption filetype=(c|cpp) %{
    set-option buffer formatcmd 'clang-format'
    set-option buffer matching_pairs '{' '}' '[' ']' '(' ')'

    try %{
        remove-highlighter buffer/operators
        add-highlighter    buffer/operators regex (\+|-|\*|&|=|\\|\?|%|\|-|!|\||->|\.|,|<|>|:|\^|/|~|\[|\]) 0:operator
    }
    try %{
        remove-highlighter buffer/delimiters
        add-highlighter    buffer/delimiters regex (\(|\)||\{|\}|\;|'|`) 0:delimiter
   }
}

hook global ModuleLoad c-family %{ try %{ evaluate-commands %sh{
    join() { sep=$2; eval set -- $1; IFS="$sep"; echo "$*"; }

    # taken from rc/filetype/c-family.kak
    c_keywords='asm break case continue default do else for goto if return
                sizeof switch while offsetof alignas alignof'
            
    # Highlight functions ignoring C specific keywords
    printf "%s\n" "add-highlighter shared/c/code/my_functions regex (\w*?)\b($(join '${c_keywords}' '|'))?(\h+)?(?=\() 1:function"
            
    # taken from rc/filetype/c-family.kak
    cpp_keywords='alignas alignof and and_eq asm bitand bitor break case catch
                  compl const_cast continue decltype delete do dynamic_cast
                  else export for goto if new not not_eq operator or or_eq
                  reinterpret_cast return sizeof static_assert static_cast switch
                  throw try typedef typeid using while xor xor_eq'

    # Highlight functions ignoring C++ specific keywords
    printf "%s\n" "add-highlighter shared/cpp/code/functions regex (\w*?)\b($(join '${cpp_keywords}' '|'))?(\h+)?(?=\() 1:function"
    # Namespace highlighting
    printf "%s\n" "add-highlighter shared/cpp/code/namespace  regex [a-zA-Z](\w+)?(\h+)?(?=::) 0:module"
    # Types and common highlightings. Same for C and C++
    for filetype in c cpp; do
        printf "%s\n" "add-highlighter shared/$filetype/code/my_field   regex ((?<!\.\.)(?<=\.)|(?<=->))[a-zA-Z](\w+)?\b(?![>\"\(]) 0:meta
                       add-highlighter shared/$filetype/code/my_method  regex ((?<!\.\.)(?<=\.)|(?<=->))[a-zA-Z](\w+)?(\h+)?(?=\() 0:function
                       add-highlighter shared/$filetype/code/my_return  regex \breturn\b 0:meta
                       add-highlighter shared/$filetype/code/my_types_1 regex \b(v|u|vu)\w+(8|16|32|64)(_t)?\b 0:type
                       add-highlighter shared/$filetype/code/my_types_2 regex \b(v|u|vu)?(_|__)?(s|u)(8|16|32|64)(_t)?\b 0:type
                       add-highlighter shared/$filetype/code/my_types_3 regex \b(v|u|vu)(_|__)?(int|short|char|long)(_t)?\b 0:type
                       add-highlighter shared/$filetype/code/my_types_4 regex \b\w+_t\b 0:type"
    done
}}}


# Rust
# # ‾‾‾‾
hook global WinSetOption filetype=rust %{
    set-option buffer formatcmd 'rustfmt'
    set-option buffer matching_pairs '{' '}' '[' ']' '(' ')'
}
    
hook global ModuleLoad rust %{ try %{ evaluate-commands %sh{
    # Taken from rc/filetype/rust.kak
    rust_keywords="let as fn return match if else loop for in while
                    break continue move box where impl dyn pub unsafe"
        
    join() { sep=$2; eval set -- $1; IFS="$sep"; echo "$*"; }
        
    # Highlight functions ignoring Rust specific keywords
    printf "%s\n" "add-highlighter shared/rust/code/functions regex ([_a-z]?\w*)\b($(join '${rust_keywords}' '|'))?\h*(?=\() 1:function"
        
    # Common highlightings for Rust
    printf "%s\n" "add-highlighter shared/rust/code/field     regex ((?<!\.\.)(?<=\.))[_a-zA-Z](\w+)?\b(?![>\"\(]) 0:meta
                   add-highlighter shared/rust/code/method    regex ((?<!\.\.)(?<=\.))[_a-zA-Z](\w+)?(\h+)?(?=\() 0:function
                   add-highlighter shared/rust/code/return    regex \breturn\b 0:meta
                   add-highlighter shared/rust/code/usertype  regex \b[A-Z]\w*\b 0:type
                   add-highlighter shared/rust/code/namespace regex [a-zA-Z](\w+)?(\h+)?(?=::) 0:module"
}}}
        
# Makefile

hook global BufCreate .*\.mk$ %{
    set-option buffer filetype makefile
}

# Normal mode mappings
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
map -docstring "comment/uncomment selection (<c-/>)" global normal ''     ': comment-line<ret>'
map -docstring "add currsor/jump on current word"    global normal '<c-d>' ': select-or-add-cursor<ret>'

# Avoid escape key
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
map -docstring "avoid escape key" global normal '<c-g>' ';<space>'
map -docstring "avoid escape key" global prompt '<c-g>' '<esc>'
map -docstring "avoid escape key" global insert '<c-g>' '<esc>'

# User Mode Mappings
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
map -docstring "convert leading spaces to tabs" global user '<a-t>' ': leading-spaces-to-tabs<ret>'
map -docstring "convert leading tabs to spaces" global user '<a-T>' ': leading-tabs-to-spaces<ret>'

## System clipboard mappings
## ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
map -docstring "copy to system clipboard"                   global user 'y' '<a-|>xsel -b -i<ret>:<space>echo -markup %{{Information}yanked selection to system clipboard}<ret>'
map -docstring "cut to system clipboard"                    global user 'd' '|xsel -b -i<ret>'
map -docstring "cut to system clipboard, enter insert mode" global user 'c' '|xsel -b -i<ret>i'
map -docstring "paste from system clipboard before cursor"  global user 'P' '!xsel --output --clipboard<ret>'
map -docstring "paste from system clipboard after cursor"   global user 'p' '<a-!>xsel --output --clipboard<ret>'
map -docstring "replace selection with system clipboard"    global user 'R' '|xsel --output --clipboard<ret>'

# Insert Mode Mappings
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
## Completion
## ‾‾‾‾‾‾‾‾‾‾
hook global InsertCompletionShow .* %{ try %{
    execute-keys -draft 'h<a-K>\h<ret>'
    map window insert <tab> <c-n>
    map window insert <s-tab> <c-p>
    map window insert <c-g> <c-o>
}}

hook global InsertCompletionHide .* %{
    unmap window insert <tab> <c-n>
    unmap window insert <s-tab> <c-p>
    unmap window insert <c-g> <c-o>
}

# Goto mode mappings
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
map -docstring "file (non-recursive)"           global goto '<a-f>' '<esc>gf'
map -docstring "file (recursive)"               global goto 'f'     '<esc>: smart-select WORD; search-file %val{selection}<ret>'
map -docstring "next buffer"                    global goto 'b'     '<esc>: buffer-next<ret>'
map -docstring "previous buffer"                global goto 'B'     '<esc>: buffer-previous<ret>'
map -docstring "search tag in current file"     global goto '['     '<esc><c-s>: smart-select word; symbol<ret>'
map -docstring "search tag in global tags file" global goto ']' '<esc><c-s>: smart-select word; ctags-search<ret>'

