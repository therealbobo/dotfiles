
### VARS ###{{{
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

set -o vi
