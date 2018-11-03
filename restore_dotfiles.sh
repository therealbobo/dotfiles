#! /bin/bash


function install_packet {
	if egrep -qi "arch" "/etc/os-release"; then
		sudo pacman -S $1
	elif egrep -qi "opensuse" "/etc/os-release"; then
		sudo zypper install $1
	elif egrep -qi "debian" "/etc/os-release"; then
		sudo apt install $1
	fi
}

function install_ohmyzsh {
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

function install_vundle {
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}


#checks
#zsh
if ! test -f /usr/bin/zsh -o -f /bin/zsh; then
	#install zsh
	echo "no zsh installed"
	install_packet "zsh"
fi

#oh-my-zsh
if ! test -d ~/.oh-my-zsh ; then
	#install oh-my-zsh
	echo "no oh-my-zsh installed"
	install_ohmyzsh
fi

#vim
if ! test -f /usr/bin/vim -o -f /bin/vim; then
	#install vim
	echo "no vim installed"
	install_packet "vim"
fi
if ! test -d ~/.vim/bundle/Vundle.vim; then
	#install Vundle
	echo "no vundle installed"
	install_vundle
fi

#tmux
if ! test -f /usr/bin/tmux -o -f /bin/tmux; then
	#install tmux
	echo "no tmux installed"
	install_packet "tmux"
fi

#create links
ln -vs ~/dotfiles/vimrc ~/.vimrc
ln -vs ~/dotfiles/tmux.conf ~/.tmux.conf
ln -vs ~/dotfiles/zshrc ~/.zshrc

#restore plugins
vim +PluginInstall +qa
