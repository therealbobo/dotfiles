#! /bin/bash

function install_packet (){
	RESULT=""
	if egrep -qi "arch" "/etc/os-release"; then
		RESULT=$(sudo pacman -S $1)
	elif egrep -qi "opensuse" "/etc/os-release"; then
		RESULT=$(sudo zypper install $1)
	elif egrep -qi "debian" "/etc/os-release"; then
		RESULT=$(sudo apt install $1)
	fi


	if $RESULT ; then
		echo "[+] $1 installed";
	else 
		echo "[-] Cannot install $1. Plese install it manually. Then ^D"
		bash
	fi
}

function check_pkg_installed (){
	which $1 1>/dev/null || install_packet $1
}

function install_ohmyzsh (){
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

function install_vundle (){
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

