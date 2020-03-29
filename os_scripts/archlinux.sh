#! /bin/bash

source "$HOME/dotfiles/scripts/utils.sh"

function install_aur_pkgman(){
	git clone https://aur.archlinux.org/yay.git
	cd yay
	sudo makepkg -si
	cd ..
	rm -rf yay
}


PACMAN="$HOME"/dotfiles/packages/archlinux/pacman.txt
AUR="$HOME"/dotfiles/packages/archlinux/aur.txt

if [ "$1" == 'install' ]; then
	sudo pacman -Syy
	grep -v -E "^#.*" "$PACMAN" | while read -r PKG; do
		sudo pacman -S --noconfirm "$PKG"
	done

	#TODO broken aur pkg install
	install_aur_pkgman

	grep -v -E "^#.*" "$AUR" | while read -r PKG; do
		yay -S --noconfirm "$PKG"
	done

	#oh-my-zsh
	sudo chsh -s /bin/zsh $(whoami)
	source $HOME/dotfiles/config_home/zshrc
	[ ! -d ~/.oh-my-zsh ] && install_ohmyzsh
fi

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
