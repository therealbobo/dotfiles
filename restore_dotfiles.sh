#! /bin/bash

source "$HOME/dotfiles/utils.sh"

cat ./packages.txt | egrep -v "^#.*" | while read PKG; do
	check_pkg_installed $PKG
done

#oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && install_ohmyzsh

#vundle 4 vim
[ ! -d ~/.vim/bundle/Vundle.vim ] && install_vundle

#create links
#ln -fs $HOME/dotfiles/vim/vimrc                  $HOME/.vimrc
ln -fs $HOME/dotfiles/vim/tex.vim                $HOME/.vim/after/ftplugin
#ln -fs $HOME/dotfiles/tmux/tmux.conf             $HOME/.tmux.conf
#ln -fs $HOME/dotfiles/zsh/zshrc                  $HOME/.zshrc
#ln -fs $HOME/dotfiles/r2/radare2rc               $HOME/.radare2rc


for DIR in $HOME/dotfiles/config/* ; do
	[ -d $HOME/.config/${DIR##*/} ] && rm -r $HOME/.config/${DIR##*/}
	ln -fs $DIR $HOME/.config
done

for DOTFILE in $HOME/dotfiles/config_home/* ; do
	ln -fs $DOTFILE $HOME/.${DOTFILE##*/}
done

#restore plugins
vim +PluginInstall +qa
wget http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl -O "$HOME/.vim/spell/it.utf-8.spl"

#restore snippets
ln -fs $HOME/dotfiles/vim/ultisnips $SNIPPETS_DIR



#other some configs
# create /etc/X11/xorg.conf.d/00-keyboard.conf to swap capslock and esc, https://superuser.com/questions/566871/how-to-map-the-caps-lock-key-to-escape-key-in-arch-linux
localectl set-x11-keymap us "" "" caps:escape


