
### VARS ###{{{
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
export KEYTIMEOUT=1
export TERM=xterm-256color
export VISUAL="vim"
export EDITOR="vim"
export MANPAGER='less -R --use-color -Dd+r -Du+b'
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

# weechat
export WEECHAT_HOME="$XDG_CONFIG_HOME"/weechat

# gnupg
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg

export _JAVA_AWT_WM_NONREPARENTING=1

###}}}


### PATH CONFIG ###{{{
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$USER_BIN:$USER_SCRIPTS
###}}}
