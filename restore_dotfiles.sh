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

echo "[-] Setting XDG dirs"

if [[ -z "$XDG_DATA_HOME" ]]; then
	echo '[!] XDG_DATA_HOME is not set. Please enter XDG_DATA_HOME (newline for default): '
	read -r XDG_DATA_HOME
	if [[ -z "$XDG_DATA_HOME" ]]; then
		XDG_DATA_HOME=${HOME}/.local/share
	fi
	if [[ ! -d "$XDG_DATA_HOME" ]]; then
		mkdir -p "$XDG_DATA_HOME"
	fi
fi

if [[ -z "$XDG_CACHE_HOME" ]]; then
	echo '[!] XDG_CACHE_HOME is not set. Please enter XDG_CACHE_HOME (newline for default): '
	read -r XDG_CACHE_HOME
	if [[ -z "$XDG_CACHE_HOME" ]]; then
		XDG_CACHE_HOME=${HOME}/.cache/
	fi
	if [[ ! -d "$XDG_CACHE_HOME" ]]; then
		mkdir -p "$XDG_CACHE_HOME"
	fi
fi

mkdir -p "$XDG_CACHE_HOME"/vim       \
		 "$XDG_DATA_HOME"/vim        \
		 "$XDG_DATA_HOME"/vim/spell  \
		 "$XDG_DATA_HOME"/vim/after  \
		 "$XDG_DATA_HOME"/vim/pack	 \
		 "$XDG_DATA_HOME"/zsh

echo "[+] Done setting XDG dirs"

echo "[-] Setting up vim"

# Install spell
curl -L 'http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl' -o "$XDG_DATA_HOME/vim/spell/it.utf-8.spl"

echo '[+] Done setting up vim'
echo '[+] All done!'
