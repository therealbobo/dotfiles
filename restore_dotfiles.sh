#! /bin/bash


function install_packet {
	RESULT=""
	if egrep -qi "arch" "/etc/os-release"; then
		RESULT=$(sudo pacman -S $1)
	elif egrep -qi "opensuse" "/etc/os-release"; then
		RESULT=$(sudo zypper install $1)
	elif egrep -qi "debian" "/etc/os-release"; then
		RESULT=$(sudo apt install $1)
	fi


	if $RESULT ; then
		echo "[+] $1 installed";
	else 
		echo "[-] Cannot install $1. Plese install it manually. Then ^D"
		bash
	fi

}


check_pkg_installed (){
	if test -f /usr/bin/$1 -o -f /bin/$1; then
		echo "[-] no $1 installed"
		echo "[-] installing $1"
		install_packet $1
	fi
}

function install_ohmyzsh {
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

function install_vundle {
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
}

PACKAGES=("zsh" "vim" "tmux" "gdb" "i3" "polybar" "zathura" "rofi" "radare2")
for PKG in $PACKAGES ; do
	check_pkg_installed $PKG
done

#oh-my-zsh
if ! test -d ~/.oh-my-zsh ; then
	#install oh-my-zsh
	echo "no oh-my-zsh installed"
	install_ohmyzsh
fi

#vundle 4 vim
if ! test -d ~/.vim/bundle/Vundle.vim; then
	#install Vundle
	echo "no vundle installed"
	install_vundle
fi

#create links
ln -vfs $HOME/dotfiles/vim/vimrc $HOME/.vimrc
mkdir -p $HOME/.vim/undodir
mkdir -p $HOME/.vim/after/ftplugin
ln -vfs $HOME/dotfiles/vim/tex.vim $HOME/.vim/after/ftplugin
ln -vfs $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf
ln -vfs $HOME/dotfiles/zsh/zshrc $HOME/.zshrc
ln -vfs $HOME/dotfiles/r2/radare2rc $HOME/.radare2rc


I3_DIR="$HOME/.config/i3"
I3STATUS_DIR="$HOME/.config/i3status"
POLYBAR_DIR="$HOME/.config/polybar"
ROFI_DIR="$HOME/.config/rofi"
TERMITE_DIR="$HOME/.config/termite"
SNIPPTES_DIR="$HOME/.vim/ultisnips"
ZATHURA_DIR="$HOME/.config/zathura"

DIRS=($I3_DIR $I3STATUS_DIR $POLYBAR_DIR $ROFI_DIR $TERMITE_DIR $SNIPPTES_DIR $ZATHURA_DIR) 

for DIR in $DIRS; do
	if ! test -d $DIR ; then
		mkdir -p $DIR
	fi
done

ln -vfs $HOME/dotfiles/i3/i3config $I3_DIR/config
#ln -vfs $HOME/dotfiles/i3/i3status $I3STATUS_DIR/config
ln -vfs $HOME/dotfiles/polybar/polybarconfig $POLYBAR_DIR/config
ln -vfs $HOME/dotfiles/polybar/polybar_launch.sh $POLYBAR_DIR/launch.sh
ln -vfs $HOME/dotfiles/rofi/roficonfig $ROFI_DIR/config
ln -vfs $HOME/dotfiles/termite/termiteconfig $TERMITE_DIR/config
ln -vfs $HOME/dotfiles/gdb/gdbinit $HOME/.gdbinit
ln -vfs $HOME/dotfiles/zathura/zathurarc $ZATHURA_DIR/zathurarc

#restore plugins
vim +PluginInstall +qa
mkdir -p "$HOME/.vim/spell"
wget http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl -O "$HOME/.vim/spell"

#restore snippets
ln -vfs $HOME/dotfiles/vim/ultisnips $SNIPPTES_DIR
