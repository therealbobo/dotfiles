#! /bin/bash

source "$HOME/dotfiles/scripts/pkg_man.sh"
source "$HOME/dotfiles/scripts/utils.sh"

mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share"

"$HOME"/dotfiles/os_scripts/"$1".sh
