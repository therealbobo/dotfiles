#! /bin/bash

function install_ohmyzsh (){
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

function install_vundle (){
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

function setup_vim (){
	[ ! -d ~/.vim/bundle/Vundle.vim ] && install_vundle
	vim +PluginInstall +qa
	mkdir -p "$HOME"/.vim/spell
	wget http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl -O "$HOME/.vim/spell/it.utf-8.spl"
	ln -fs "$HOME"/dotfiles/vim/ultisnips   "$HOME"/.vim
	ln -fs "$HOME"/dotfiles/vim/tex.vim     "$HOME"/.vim/after/ftplugin
}
