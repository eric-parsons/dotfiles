DEFAULT_USER=eric

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Expand aliases with Tab key instead of Ctrl-X + A.
# autoload -Uz compinit; compinit;
bindkey "^Xa" _expand_alias
zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' regular true

plugins=(git vi-mode)

# Enable vim-style keyboard shortcuts.
VI_MODE_SET_CURSOR=true
bindkey -v

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='mvim'

alias e=nvim

# Alias to manage bare repo which is used for versioning dotfiles in the home
# directory.
alias df="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"

# npm aliases.
alias ni="npm install"
alias ns="npm start"
alias nb="npm run build"
alias nbw="npm run build-watch"
alias nt="npm test"
alias ntw="npm test-watch"
alias nl="npm run lint"
alias np="npm run prettier"

