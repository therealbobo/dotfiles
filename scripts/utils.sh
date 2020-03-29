#! /bin/bash

function install_ohmyzsh (){
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	mv .oh-my-zsh "$XDG_DATA_HOME/oh-my-zsh"
}

function install_vundle (){
	git clone https://github.com/VundleVim/Vundle.vim.git $XDG_DATA_HOME/vim/bundle/Vundle.vim
}

function setup_vim (){
	# Install Vundle (plugin manager)
	[ ! -d "$XDG_DATA_HOME"/vim/Vundle.vim ] && install_vundle
	vim +PluginInstall +qa

	mkdir -p "$XDG_DATA_HOME"/vim
	mkdir -p "$XDG_CACHE_HOME"/vim
	[ ! -f "$XDG_CACHE_HOME"/vim/viminfo ] && touch "$XDG_CACHE_HOME"/vim/viminfo
	
	# Install spell and snippests
	mkdir -p "$XDG_DATA_HOME"/vim/spell
	mkdir -p "$XDG_DATA_HOME"/vim/after
	wget http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl -O "$XDG_DATA_HOME/vim/spell/it.utf-8.spl"
	ln -fs "$HOME"/dotfiles/vim/ultisnips   "$XDG_DATA_HOME"/vim
	ln -fs "$HOME"/dotfiles/vim/tex.vim     "$XDG_DATA_HOME"/vim/after/ftplugin
}
