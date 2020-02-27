#! /bin/bash

source "$HOME/dotfiles/scripts/utils.sh"


APT="$HOME"/dotfiles/packages/ubuntu/apt.txt
SNAP="$HOME"/dotfiles/packages/ubuntu/snap.txt

sudo apt update
grep -v -E "^#.*" "$APT" | while read -r PKG; do
	sudo apt install -y "$PKG"
done

grep -v -E "^#.*" "$SNAP" | while read -r PKG; do
	sudo snap install -y "$PKG"
done

#oh-my-zsh
sudo chsh -s /bin/zsh $(whoami)
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
#localectl set-x11-keymap us "" "" caps:escape
