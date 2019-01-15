# FrameWork OHMYZSH
export ZSH="/home/dark/.oh-my-zsh"

# Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="spaceship"
#ZSH_THEME="minimal"
#ZSH_THEME="gallois"
ZSH_THEME="marc"
#ZSH_THEME="dudu"

# Plugins
plugins=(
  virtualenvwrapper
  pyenv
  git
)

source $ZSH/oh-my-zsh.sh

# Configuração do ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"


# System packages Arch Linux
alias install="yay -S"
alias search="yay -Ss"
alias up="yay -Syu"
alias remove="yay -R"
alias del="yay -Rs"

# System Tools
alias ra="ranger"
alias rs="sudo ranger"
alias rco="ranger ~/MEGAsync"
alias mfetch="~/./mfetch"
alias c="cat"
alias sr="source ~/.zshrc"
alias xi="nvim ~/.xinitrc"
alias xsc="xrdb -merge ~/.Xresources"

# config Editor && Shell
alias con="nvim ~/.config/nvim/init.vim"
alias cov="nvim ~/.vimrc"
alias zco="nvim ~/.zshrc"
alias comp="~/scripts/tools/./compiler"

# config WMS 
alias qcon="nvim ~/.config/qtile/config.py"
alias bcon="nvim ~/.config/bspwm/bspwmrc"
alias dcon="nvim ~/dwm/config.h"
alias pcon="nvim ~/.config/polybar/config"
alias kcon="nvim ~/.config/sxhkd/sxhkdrc"

# Programas
alias stremio="/usr/share/stremio/./Stremio-runtime"

# Diretorios
alias ll="ls -Fla --color"
alias ls="ls -F --color"

# Ambiente de Desenvolvimento
alias work="workon project" # Ambiente virtual de desenvolvimento CDD
alias site="workon site"
alias s="deactivate"
alias list="workon"

# Atalhos pessoais
alias note="nvim ~/MEGAsync/Notebooking/index.md"
alias dados="emacs ~/MEGAsync/Notas/Anotações.org"

# Configurações ZSH
source /home/dark/Git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Virtualenv and VirtualenvWrapper
export WORKON_HOME=$HOME/.virtualenv
export PROJECT_HOME=$HOME/Projetos/estudo-python
# export VIRTUALENVWRAPPER_SCRIPT
source /usr/bin/virtualenvwrapper.sh

# export PATH="${PATH}:~/scripts"

