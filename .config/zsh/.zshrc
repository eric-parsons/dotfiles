# These settings assume the following tools are installed:
#   brew install neovim fzf zoxide eza bat
# It also requires git, which can be installed via xcode command line tools or
# homebrew.

###########
# Options #
###########

# So annoying!
setopt nobeep

# cd options.
setopt autocd autopushd cdsilent

# History options.
HISTFILE=$XDG_CONFIG_HOME/zsh/.zshhistory
HISTSIZE=10000
SAVEHIST=10000
setopt sharehistory appendhistory histignorealldups histignorespace 

# Preferred editor.
export EDITOR="nvim"
export VISUAL="nvim"

# Make the less pager use case-insensitive search (also used
# by `man`).
export LESS="-isR"

# Make man pages more readable on wide screens by wrapping at 80 characters.
export MANPAGER="sh -c 'fmt | less'"

###################
# iTerm2 Profiles #
###################

# Switch to the nth profile in the list, e.g. "prof 5". Each of these profiles
# has a different background image and transparency, so in effect this switches
# the background.
function prof() {
    PROFILES=(profile1 profile2 profile3 profile4 profile5 profile6 profile7 profile8 profile9 profile10 profile11)
    echo -e "\033]50;SetProfile=$PROFILES[$1]\a"
}

# Pick a random profile on startup. Do this as early as posssible so that there
# is no delay before the image shows. 
if [[ $(uname) == "Darwin" ]]; then
    prof $(jot -r 1 1 11)
fi

###########
# Plugins #
###########

# Dirt simple "plugin manager". Takes the github repo name as input.
# Inspired by https://www.youtube.com/watch?v=bTLYiNvRIVI
function plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    PLUGIN_DIR="$ZDOTDIR/plugins/$PLUGIN_NAME"
    if [ ! -d "$PLUGIN_DIR" ]; then
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
    source "$PLUGIN_DIR/$PLUGIN_NAME.plugin.zsh"
}

plugin zsh-users/zsh-syntax-highlighting
plugin zsh-users/zsh-autosuggestions
plugin softmoth/zsh-vim-mode

################
# Autocomplete #
################

autoload -Uz compinit; compinit

# Show hidden files.
_comp_options+=(globdots)

# Use a menu that can be navigated with arrow keys in addition to tab.
zstyle ':completion:*' menu select

# Use color output for completion similar to ls --color=auto. On Linux,
# LS_COLORS may already be set. In macOS/BSD, a different variable LSCOLORS
# with a different syntax is used, and is not compatible with zsh competion, so
# it needs to be set manually. Can be configured with this tool:
# https://geoff.greer.fm/lscolors/
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#######
# bat #
#######

export BAT_THEME=ansi

##########
# zoxide #
##########

# Set up zoxide completion and set it as a replacement for cd. This also adds a
# cdi alias (interactive search through zoxide history).
eval "$(zoxide init zsh --cmd cd)"

#######
# fzf #
#######

# Set up fzf key bindings and fuzzy completion.
# Sets up these shortcuts:
#   **<tab>: Fuzzy completion (context sensitive based on what precedes **)
#   ctrl-t:  Fuzzy insert
#   ctrl-r:  Fuzzy history search
#   esc-c:   cd to fuzzy directory search
source <(fzf --zsh)

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules
  --preview 'bat -n --color=always --line-range=:500 {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

##############
# Vi(m) Mode #
##############

# Enable vim-style keyboard shortcuts on the command line.
bindkey -v

# Speeds up switching to normal mode via esc. Setting this too low can make it
# impossible to use surround commands added by the zsh-vim-mode plugin above
# (e.g. typing cs'" to change surrounding single quotes to double quotes). For
# me, anything lower than 25 (250ms) means I mess up those sequences a good
# chunk of the time. YMMV.
KEYTIMEOUT=25

# Use a different cursor in insert mode to differentiate it from normal mode
# (block cursor by default). See https://github.com/softmoth/zsh-vim-mode.
MODE_CURSOR_VIINS="red steady bar"

###########
# Aliases #
###########

# Use eza as a replacement for ls and tree commands.
alias ls="eza -w 80 --color=auto --icons=auto"
alias ll="eza -lh --color=auto --icons=auto --git --time-style=long-iso"
alias tree="eza --tree -I 'node_modules|.git' --color=auto --icons=auto"
# Paginated versions that preserve colors and icons.
function llp () {
    ll --color=always --icons=always $@ | less -r
}
function treep () {
    tree --color=always --icons=always $@ | less -r
}

# Misc
alias e=nvim
alias g=lazygit

# Directories
alias ds="dirs -p"
alias b=popd # "back", like in a browser.

# Alias to manage bare repo which is used for versioning dotfiles in the home
# directory.
alias df="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"

# npm aliases
alias ni="npm install"
alias ns="npm start"
alias nt="npm test"
# These are not standard npm commands, but conventions I tend to use.
alias nb="npm run build"
alias nbw="npm run build-watch"
alias ntw="npm run test-watch"
alias nl="npm run lint"
alias np="npm run prettier"

##########
# Prompt #
##########

eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/oh-my-posh/custom.toml)"

#################
# Haskell Tools #
#################

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
