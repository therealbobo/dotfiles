#! /bin/bash

PKG_DIR="$1"
RET=0

cat "$PKG_DIR/*" | grep -v -E "^#.*" | while read PKG; do
	command -v $PKG 1>&2 2>/dev/null
	if [ $? != 0 ]; then
		echo "[!] $PKG not installed!"
		RET=1
	else;
		echo "[+] $PKG ok"
	fi
done
