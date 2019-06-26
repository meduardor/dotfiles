# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort size
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-_]=** r:|=**'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' menu select=1
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt '1'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/merds/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install

# Alias Config 

# Packages 
##############################NixOS
#alias install="nix-env -i"
#alias search="nix-env -qaP | grep"
#alias search_ni="nix-env -f "<nixpkgs>" -qaP -A"
#alias search_n="nix-env -f "<nixos>" -qaP -A"
#alias remove="nix-env --uninstall"
#alias del="nix-env garbage -d"
#alias pkg_in="nix-env -iA"
###############################VoidLinux
alias install="sudo xbps-install -S"
alias search="xbps-query -Rs"
alias remove="sudo xbps-remove -R"
alias up="sudo xbps-install -Suv"

# File System
alias ls='ls --color=auto' 
alias l="ls -l"
alias ll="ls -Fla"
alias la="ls -aF"

# Source file
alias sr="source ~/.zshrc"
alias xr="xrdb -merge ~/.Xresources"
#alias xm="xmonad --recompile && xmonad --restart"

# Conf File 
alias von="nvim ~/.config/nvim/init.vim"
alias con="nvim ~/.config/i3/config"
#alias ala="nvim ~/.config/alacritty/alacritty.yml"
alias zon="nvim ~/.zshrc"
alias cob="nvim ~/.bashrc"
#alias conf="sudo nvim /etc/nixos/configuration.nix"
#alias note="nvim ~/Estudos/Anotações/Index.md"

# Config Programs
alias vi="nvim"
alias n="nnn"
alias zz="zathura"
alias macs="emacs -nw"
alias work="cd ~/Projetos"
#alias tmux="TERM=xterm-256color tmux"
# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nnn
export NNN_OPENER=zathura
export NNN_FALLBACK_OPENER=zathura

# Config ZSH 
source ~/Git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/Git/zsh-autosuggestions/zsh-autosuggestions.zsh

# Only load Liquid Prompt in interactive shells, not from a script or from scp
 [[ $- = *i* ]] && source ~/liquidprompt/liquidprompt

# Theme (ZSH)

export VIRTUAL_ENV_DISABLE_PROMPT=1
virtualenv_info() {
    [ "$VIRTUAL_ENV" ] && echo '('"%F{blue}$(basename "$VIRTUAL_ENV")"%f') '
}
PR_GIT_UPDATE=1

setopt prompt_subst
autoload -U add-zsh-hook
autoload -Uz vcs_info

# use extended color palette if available.
if [[ "${terminfo[colors]}" -ge 256 ]]; then
    turquoise="%F{73}"
    orange="%F{179}"
    purple="%F{140}"
    red="%F{167}"
    limegreen="%F{107}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    red="%F{hotpink}"
    limegreen="%F{green}"
fi

# enable VCS systems you use.
zstyle ':vcs_info:*' enable git svn

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories.
zstyle ':vcs_info:*:prompt:*' check-for-changes true

# set formats.
PR_RST="%f"
FMT_BRANCH="(%{$turquoise%}%b%u%c${PR_RST})"
FMT_ACTION="(%{$limegreen%}%a${PR_RST})"
FMT_UNSTAGED="%{$orange%} ●"
FMT_STAGED="%{$limegreen%} ✚"

zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGED}"
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGED}"
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

oxide_preexec() {
    case "$2" in
        *git*)
            PR_GIT_UPDATE=1
            ;;
        *hub*)
            PR_GIT_UPDATE=1
            ;;
        *svn*)
            PR_GIT_UPDATE=1
            ;;
    esac
}
add-zsh-hook preexec oxide_preexec

oxide_chpwd() {
    PR_GIT_UPDATE=1
}
add-zsh-hook chpwd oxide_chpwd

oxide_precmd() {
    if [[ -n "$PR_GIT_UPDATE" ]] ; then
        # check for untracked files or updated submodules, since vcs_info doesn't.
        if git ls-files --other --exclude-standard 2> /dev/null | grep -q "."; then
            PR_GIT_UPDATE=1
            FMT_BRANCH="on %{$turquoise%} %b%u%c%F{red} ● ${PR_RST}"
        else
            FMT_BRANCH="on %{$turquoise%} %b%u%c${PR_RST}"
        fi
        zstyle ':vcs_info:*:prompt:*' formats "${FMT_BRANCH} "

        vcs_info 'prompt'
        PR_GIT_UPDATE=
    fi
}
add-zsh-hook precmd oxide_precmd

PROMPT=$'
%{$limegreen%}%~${PR_RST} $vcs_info_msg_0_$(virtualenv_info)
%(?.%F{white}.%F{red})$%f '


