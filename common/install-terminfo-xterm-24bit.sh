#!/bin/bash

# thanks to jclosure
# https://gitlab.com/jclosure/dotfiles/-/blob/develop/common/install-terminfo-xterm-24bit.sh
# adds a terminfo entry defining a new terminal xterm-24bit
# If you run emacs (26.1+) setting TERM=xterm-24bit, then it
# will use 24bit color

echo -ne "[-] installing termifo xterm-24bit\r"

TMP=$(mktemp -d)

cat <<EOF > ${TMP}/terminfo-24bit.src
# Use colon separators.
xterm-24bit|xterm with 24-bit direct color mode,
  use=xterm-256color,
  setb24=\E[48:2:%p1%{65536}%/%d:%p1%{256}%/%{255}%&%d:%p1%{255}%&%dm,
  setf24=\E[38:2:%p1%{65536}%/%d:%p1%{256}%/%{255}%&%d:%p1%{255}%&%dm,
# Use semicolon separators.
xterm-24bits|xterm with 24-bit direct color mode,
  use=xterm-256color,
  setb24=\E[48;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
  setf24=\E[38;2;%p1%{65536}%/%d;%p1%{256}%/%{255}%&%d;%p1%{255}%&%dm,
EOF

tic -x -o ~/.terminfo ${TMP}/terminfo-24bit.src
rm -rf $TMP

echo '[+] Done installing termifo xterm-24bit'
