
### VARS ###{{{
export ZSH="$HOME/.local/share/oh-my-zsh"
export TERM=xterm-256color
export VISUAL="vim"
export EDITOR="vim"
###}}}

### XDG-CONFIGS ###{{{
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export USER_BIN=$HOME/.local/bin
export USER_SCRIPTS=$HOME/.local/scripts

# golang
export GOPATH=$XDG_DATA_HOME/golang

# less
#export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE=-

# parallel
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel

# vagrant
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME"/vagrant/aliases

# z TODO broken
export _Z_DATA="$XDG_DATA_HOME/z"

# mplayer
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer

# weechat
export WEECHAT_HOME="$XDG_CONFIG_HOME"/weechat

# weechat
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg

export _JAVA_AWT_WM_NONREPARENTING=1

###}}}


### PATH CONFIG ###{{{
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$USER_BIN:$USER_SCRIPTS
###}}}

#ZSH_THEME="../../../../.config/zsh/bobo"
PROMPT='%(?.%F{green}√.%F{red}✗ %?)%f' # error handling
PROMPT+=' %F{green}%B%n@%M%b%f:'       # username@hostname
PROMPT+='%F{blue}%2~%f %# '          # pwd

COMPLETION_WAITING_DOTS="true"

# TODO mv histfile
[ ! -f "$XDG_DATA_HOME"/vim/histfile ] && touch "$XDG_DATA_HOME"/vim/histfile
HISTFILE="$XDG_DATA_HOME"/vim/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd notify
bindkey -v
bindkey '^R' history-incremental-search-backward

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# git support
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit -d $ZSH_COMPDUMP

export KEYTIMEOUT=1

### SOURCES ###{{{
source "$XDG_CONFIG_HOME/zsh/aliases"
#source "$ZSH/oh-my-zsh.sh"
###}}}

