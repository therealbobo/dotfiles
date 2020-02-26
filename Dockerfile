#
# therealbobo dotfiles Dockerfile
#
# https://github.com/therealbobo/dotfiles
#

FROM archlinux:latest


RUN pacman -Syy
RUN pacman -S --no-confirm git
RUN git clone https://github.com/therealbobo/dotfiles
RUN cd dotfiles && ./restore_dotfiles.sh
