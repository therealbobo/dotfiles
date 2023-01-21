#!/bin/bash

DARWIN_PKGS=('emacs' 'vim' 'zsh' 'tmux' 'starship' 'wget' 'radare2')

! command -v stow 1>/dev/null && echo '[!] Please install stow!' && exit 1
! command -v curl 1>/dev/null && echo '[!] Please install curl!' && exit 1

echo "[-] Start stowing"
if [[ `uname -a | cut -d' ' -f 1` == 'Darwin' ]]; then
	for PKG in ${DARWIN_PKGS[@]}; do
		stow -v 1 -R -t ~ $PKG 2>&1 | grep 'WARNING! unstowing' -A1
	done
else
	find * -maxdepth 0 -type d -exec stow -v 1 -R -t ~ {} \; 2>&1 | grep 'WARNING! unstowing' -A1
fi
echo "[+] Done stowing"

echo "[-] Setting up vim"

if [ -z "$XDG_DATA_HOME" ]; then
	echo '[!] XDG_DATA_HOME is not set. Please enter XDG_DATA_HOME: '
	read -r XDG_DATA_HOME
fi

if [ -z "$XDG_CACHE_HOME" ]; then
	echo '[!] XDG_CACHE_HOME is not set. Please enter XDG_CACHE_HOME: '
	read -r XDG_CACHE_HOME
fi

mkdir -p "$XDG_CACHE_HOME"/vim       \
		 "$XDG_DATA_HOME"/vim        \
		 "$XDG_DATA_HOME"/vim/spell  \
		 "$XDG_DATA_HOME"/vim/after  \
		 "$XDG_DATA_HOME"/vim/pack	 \
		 "$XDG_DATA_HOME"/zsh

[ ! -f "$XDG_CACHE_HOME"/vim/viminfo ] && touch "$XDG_CACHE_HOME"/vim/viminfo

# Install spell and snippests
curl -L 'http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl' -o "$XDG_DATA_HOME/vim/spell/it.utf-8.spl"

echo '[+] Done settinging up vim'
echo '[+] All done!'
