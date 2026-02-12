#!/bin/bash

DARWIN_PKGS=('emacs' 'vim' 'zsh' 'tmux' 'starship' 'wget' 'radare2')

! command -v stow 1>/dev/null && echo '[!] Please install stow!' && exit 1
! command -v curl 1>/dev/null && echo '[!] Please install curl!' && exit 1
! command -v git  1>/dev/null && echo '[!] Please install git!' && exit 2

echo "[-] Start stowing"
if [[ `uname -a | cut -d' ' -f 1` == 'Darwin' ]]; then
	for PKG in ${DARWIN_PKGS[@]}; do
		stow -v 1 -R -t ~ $PKG 2>&1 | grep 'WARNING! unstowing' -A1
	done
else
	find * -maxdepth 0 -type d | grep -v '^common$' | \
		xargs -I@ stow -v 1 -R -t ~ @ 2>&1 | grep 'WARNING! unstowing' -A1
fi
echo "[+] Done stowing"

echo "[-] Setting XDG dirs"

read -r -p "[!] XDG_CACHE_HOME (Enter for default: $HOME/.cache): " input
export XDG_CACHE_HOME="${input:-${XDG_CACHE_HOME:-$HOME/.cache}}"

read -r -p "[!] XDG_CONFIG_HOME (Enter for default: $HOME/.config): " input
export XDG_CONFIG_HOME="${input:-${XDG_CONFIG_HOME:-$HOME/.config}}"

read -r -p "[!] XDG_DATA_HOME (Enter for default: $HOME/.local/share): " input
export XDG_DATA_HOME="${input:-${XDG_DATA_HOME:-$HOME/.local/share}}"

mkdir -p "$XDG_CACHE_HOME"/vim       \
		 "$XDG_DATA_HOME"/vim        \
		 "$XDG_DATA_HOME"/vim/spell  \
		 "$XDG_DATA_HOME"/vim/pack	 \
		 "$XDG_DATA_HOME"/zsh        \
		 "$XDG_CONFIG_HOME"

echo "[+] Done setting XDG dirs"

echo "[-] Setting up vim"

# Install spell
if [[ ! -f "$XDG_DATA_HOME/vim/spell/it.utf-8.spl" ]]; then
	curl -L 'http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl' -o "$XDG_DATA_HOME/vim/spell/it.utf-8.spl"
fi

echo '[+] Done setting up vim'

echo '[-] Setting up tmux'
if [[ ! -d "${XDG_CONFIG_HOME}/tmux/plugins/tpm" ]]; then
	git clone https://github.com/tmux-plugins/tpm "${XDG_CONFIG_HOME}/tmux/plugins/tpm"
fi
echo '[+] Done setting up tmux'

echo '[-] Do common things'

find ./common -type f -exec {} \;

echo '[+] All done!'
