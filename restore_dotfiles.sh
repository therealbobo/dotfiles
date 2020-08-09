#! /bin/bash


command -v stow 1>/dev/null || eval "echo '[!] Please install stow!'; exit"

find * -maxdepth 0 -type d -exec stow -v 1 -R -t ~ {} \;

source util.sh
install_ohmyzsh
install_vundle
setup_vim
