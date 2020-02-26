#! /bin/bash

source "$HOME/dotfiles/scripts/pkg_man.sh"
source "$HOME/dotfiles/scripts/utils.sh"

set_pkgman

grep -v -E "^#.*" "$HOME"/dotfiles/packages.txt | while read -r PKG; do
	check_and_install "$PKG"
done

#oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && install_ohmyzsh

for DIR in "$HOME"/dotfiles/config/* ; do
	[ -d "$HOME/.config/${DIR##*/}" ] && rm -r "$HOME/.config/${DIR##*/}"
	ln -fs "$DIR" "$HOME"/.config
done

for DOTFILE in "$HOME"/dotfiles/config_home/* ; do
	ln -fs "$DOTFILE" "$HOME/.${DOTFILE##*/}"
done

setup_vim

# create /etc/X11/xorg.conf.d/00-keyboard.conf to swap capslock and esc, https://superuser.com/questions/566871/how-to-map-the-caps-lock-key-to-escape-key-in-arch-linux
sudo localectl set-x11-keymap us "" "" caps:escape
