#! /bin/bash

function set_pkgman(){
	[ -f /tmp/pkgman ] && return

	OS=$(cat /etc/os-release | grep -e '^NAME' | cut -d\" -f2)
	case "$OS" in
	"Arch Linux")
		sudo pacman -Syu
		echo 'sudo pacman -S --noconfirm ' > /tmp/pkgman
	  ;;
	"Debian"*)
		sudo apt update
		echo 'sudo apt install -y ' > /tmp/pkgman
	  ;;
	esac
}

function install (){
	CMD=$(cat /tmp/pkgman)
	PKG=$1
	if $CMD $PKG; then 
		echo "[+] $1 installed";
	else 
		echo "[-] Cannot install $1. Please install it manually. Then ^D"
		bash
	fi
}

function check_and_install (){
	which $1 &>/dev/null || install $1
}

