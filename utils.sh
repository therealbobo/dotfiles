#! /bin/bash

function install_native_plugins (){
	mkdir -p "$XDG_DATA_HOME"/vim/pack/plugins
	PACKAGES=(
		'VundleVim/Vundle.vim'
		'itchyny/lightline.vim'
		'bling/vim-bufferline'
		'lervag/vimtex'
		'SirVer/ultisnips'
	)
	for PKG in ${PACKAGES[@]}; do
		git clone "https://github.com/$PKG" $XDG_DATA_HOME/vim/pack/plugins/${PKG##*/}
	done
	
}


function setup_vim (){
	mkdir -p "$XDG_DATA_HOME"/vim
	mkdir -p "$XDG_CACHE_HOME"/vim
	[ ! -f "$XDG_CACHE_HOME"/vim/viminfo ] && touch "$XDG_CACHE_HOME"/vim/viminfo
	
	# Install spell and snippests
	mkdir -p "$XDG_DATA_HOME"/vim/spell
	mkdir -p "$XDG_DATA_HOME"/vim/after
	mkdir -p "$XDG_DATA_HOME"/vim/pack
	wget http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl -O "$XDG_DATA_HOME/vim/spell/it.utf-8.spl"
}
