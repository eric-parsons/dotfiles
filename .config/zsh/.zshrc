# So annoying!
setopt nobeep

# cd options.
setopt autocd autopushd cdsilent

# History options.
setopt appendhistory histignorealldups

# Switch to the given iterm2 profile by number, e.g. "prof 5". Each of these
# profiles has a different background image and transparency, so in effect this
# switches the background.
function prof() {
    PROFILES=(profile1 profile2 profile3 profile4 profile5 profile6 profile7 profile8 profile9 profile10 profile11)
    echo -e "\033]50;SetProfile=$PROFILES[$1]\a"
}

# Pick a random profile. Do this as early as posssible so that there is no
# delay before the image shows. The jot command is available on BSD/macOS but
# may not be available on Linux. Use the "shuf" command in as a substitute in
# that case.
prof $(jot -r 1 1 11)


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

# Expand aliases with Tab key instead of Ctrl-X + A.
autoload -Uz compinit; compinit;
bindkey "^Xa" _expand_alias
zstyle ':completion:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' regular true

# Enable vim-style keyboard shortcuts.
bindkey -v
KEYTIMEOUT=25
MODE_CURSOR_VIINS="red steady bar"

# Preferred editor for local and remote sessions
export EDITOR="nvim"
export VISUAL="nvim"

# Make the less pager use case-insensitive search (also used
# by `man`).
export LESS="-i"

# Make man pages more readable on wide screens by wrapping at 80 characters.
export MANPAGER="fmt -w 80 | less"

# Misc aliases.
alias ls="ls --color"
alias e=nvim
alias g=lazygit
alias b=popd

# Alias to manage bare repo which is used for versioning dotfiles in the home
# directory.
alias df="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"

# npm aliases.
alias ni="npm install"
alias ns="npm start"
alias nb="npm run build"
alias nbw="npm run build-watch"
alias nt="npm test"
alias ntw="npm run test-watch"
alias nl="npm run lint"
alias np="npm run prettier"

# Set up prompt. 
eval "$(oh-my-posh init zsh --config $XDG_CONFIG_HOME/oh-my-posh/custom.toml)"

