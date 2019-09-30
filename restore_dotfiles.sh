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
ln -vfs $HOME/dotfiles/vimrc $HOME/.vimrc
mkdir -p $HOME/.vim/undodir
mkdir -p $HOME/.vim/after/ftplugin
ln -vfs $HOME/dotfiles/tex.vim $HOME/.vim/after/ftplugin
ln -vfs $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
ln -vfs $HOME/dotfiles/zshrc $HOME/.zshrc
ln -vfs $HOME/dotfiles/radare2rc $HOME/.radare2rc


I3_DIR="$HOME/.config/i3"
I3STATUS_DIR="$HOME/.config/i3status"
POLYBAR_DIR="$HOME/.config/polybar"
ROFI_DIR="$HOME/.config/rofi"
TERMITE_DIR="$HOME/.config/termite"
SNIPPTES_DIR="$HOME/.vim/ultisnips"
ZATHURA_DIR="$HOME/.config/zathura"

if ! test -d $I3_DIR ; then
	mkdir -p $I3_DIR
fi
if ! test -d $I3STATUS_DIR ; then
	mkdir -p $I3STATUS_DIR
fi
if ! test -d $POLYBAR_DIR ; then
	mkdir -p $POLYBAR_DIR
fi
if ! test -d $ROFI_DIR ; then
	mkdir -p $ROFI_DIR
fi
if ! test -d $ZATHURA_DIR ; then
	mkdir -p $ZATHURA_DIR
fi
ln -vfs $HOME/dotfiles/i3config $I3_DIR/config
#ln -vfs $HOME/dotfiles/i3status $I3STATUS_DIR/config
ln -vfs $HOME/dotfiles/polybarconfig $POLYBAR_DIR/config
ln -vfs $HOME/dotfiles/polybar_launch.sh $POLYBAR_DIR/launch.sh
ln -vfs $HOME/dotfiles/roficonfig $ROFI_DIR/config
ln -vfs $HOME/dotfiles/termiteconfig $TERMITE_DIR/config
ln -vfs $HOME/dotfiles/zathurarc $ZATHURA_DIR/zathurarc

#restore plugins
vim +PluginInstall +qa
mkdir -p "$HOME/.vim/spell"
wget http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl -O "$HOME/.vim/spell"

#restore snippets
ln -vfs $HOME/dotfiles/ultisnips $SNIPPTES_DIR
