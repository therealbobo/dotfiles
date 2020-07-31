#! /bin/bash


command -v stow 1>/dev/null || eval "echo '[!] Please install stow!'; exit"

find * -maxdepth 0 -type d -exec stow -v -R -t ~ {} \;
