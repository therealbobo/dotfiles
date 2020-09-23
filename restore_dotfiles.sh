#! /bin/bash

REDB='\033[01;31m'
GREENB='\033[01;32m'
BOLD='\033[1m'
DEF='\033[00;39m'

source utils.sh

command -v stow 1>/dev/null || eval "echo '[!] Please install stow!'; exit"

echo -e "$BOLD[-] Start stowing"
echo -ne "$REDB"
find * -maxdepth 0 -type d -exec stow -v 1 -R -t ~ {} \; 2>&1 | grep 'WARNING! unstowing' -A1
echo -e "$GREENB[+] Done stowing$DEF"


echo -e "$BOLD[-] Setting up vim$DEF"
setup_vim
echo -ne "$GREENB"
echo '[+] Done settinging up vim'
echo '[+] All done!'
echo -ne "$DEF"
