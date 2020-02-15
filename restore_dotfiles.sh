#! /bin/bash

source "$HOME/dotfiles/dirs.sh"
source "$HOME/dotfiles/utils.sh"



cat ./packages.txt | egrep -v "^#.*" | while read PKG; do
	check_pkg_installed $PKG
done

#oh-my-zsh
[! test -d ~/.oh-my-zsh ] && install_ohmyzsh

#vundle 4 vim
[! test -d ~/.vim/bundle/Vundle.vim ] && install_vundle


for DIR in ${DIRS[@]}; do
	[! -d $DIR] && mkdir -p $DIR
done

#create links
ln -vfs $HOME/dotfiles/vim/vimrc                  $HOME/.vimrc
ln -vfs $HOME/dotfiles/vim/tex.vim                $HOME/.vim/after/ftplugin
ln -vfs $HOME/dotfiles/tmux/tmux.conf             $HOME/.tmux.conf
ln -vfs $HOME/dotfiles/zsh/zshrc                  $HOME/.zshrc
ln -vfs $HOME/dotfiles/r2/radare2rc               $HOME/.radare2rc


ln -vfs $HOME/dotfiles/bspwm/bspwmrc              $BSPWM_DIR/bspwmrc
ln -vfs $HOME/dotfiles/dunst/dunstrc              $DUNST_DIR/dunstrc
ln -vfs $HOME/dotfiles/gdb/gdbinit                $HOME/.gdbinit
ln -vfs $HOME/dotfiles/i3/i3config                $I3_DIR/config
ln -vfs $HOME/dotfiles/i3/i3status                $I3STATUS_DIR/config
ln -vfs $HOME/dotfiles/polybar/polybar_launch.sh  $POLYBAR_DIR/launch.sh
ln -vfs $HOME/dotfiles/polybar/polybarconfig      $POLYBAR_DIR/config
ln -vfs $HOME/dotfiles/rofi/roficonfig            $ROFI_DIR/config
ln -vfs $HOME/dotfiles/sxhkd/sxhkdrc              $SXHKD_DIR/sxhkdrc
ln -vfs $HOME/dotfiles/termite/termiteconfig      $TERMITE_DIR/config
ln -vfs $HOME/dotfiles/zathura/zathurarc          $ZATHURA_DIR/zathurarc

#restore plugins
vim +PluginInstall +qa
wget http://ftp.vim.org/pub/vim/runtime/spell/it.utf-8.spl -O "$HOME/.vim/spell"

#restore snippets
ln -vfs $HOME/dotfiles/vim/ultisnips $SNIPPTES_DIR


#other some configs
# create /etc/X11/xorg.conf.d/00-keyboard.conf to swap capslock and esc, https://superuser.com/questions/566871/how-to-map-the-caps-lock-key-to-escape-key-in-arch-linux
localectl set-x11-keymap us "" "" caps:escape


