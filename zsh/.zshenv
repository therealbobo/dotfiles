### XDG-CONFIGS ###{{{
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export USER_BIN=$HOME/.local/bin
export USER_SCRIPTS=$HOME/.local/scripts

### VARS ###{{{
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export TERM=xterm-256color
export VISUAL="vim"
export EDITOR="vim"
###}}}

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

# gnupg
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg

# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# cuda
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

# pylint
export PYLINTHOME="$XDG_CACHE_HOME"/pylint

# gtk
export GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-1.0/gtkrc"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"

# gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

# node
export npm_config_prefix=$XDG_DATA_HOME/node_modules

# android
export ANDROID_PREFS_ROOT="$XDG_CONFIG_HOME"/android
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME"/android/emulator

# java
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java -Dawt.useSystemAAFontSettings=on"

# ruby
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem

# ipython/jupyter
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter

# qt
export QT_SCALE_FACTOR_ROUNDING_POLICY=Round

# nnn
export NNN_PLUG='z:autojump;d:dragdrop'

### PATH CONFIG ###{{{
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$USER_BIN:$USER_SCRIPTS:$npm_config_prefix/bin
###}}}
