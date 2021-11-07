#! /bin/sh

! command -v stow 1>/dev/null && echo '[!] Please install stow!' && exit 1

echo "[-] Start stowing"
find * -maxdepth 0 -type d -exec stow -v 1 -R -t ~ {} \; 2>&1 | grep 'WARNING! unstowing' -A1
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

mkdir -p "$XDG_DATA_HOME"/vim
mkdir -p "$XDG_CACHE_HOME"/vim
[ ! -f "$XDG_CACHE_HOME"/vim/viminfo ] && touch "$XDG_CACHE_HOME"/vim/viminfo

# Install spell and snippests
mkdir -p "$XDG_DATA_HOME"/vim/spell
mkdir -p "$XDG_DATA_HOME"/vim/after
mkdir -p "$XDG_DATA_HOME"/vim/pack
wget http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl -O "$XDG_DATA_HOME/vim/spell/it.utf-8.spl"

echo '[+] Done settinging up vim'
echo '[+] All done!'
