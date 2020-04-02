#
# therealbobo dotfiles Dockerfile
#
# https://github.com/therealbobo/dotfiles
#

FROM archlinux:latest


USER root

RUN pacman -Syy && pacman -S --noconfirm sudo git
RUN echo 'therealbobo     ALL=(ALL) NOPASSWD:ALL' | tee /etc/sudoers && \
    useradd -d /home/therealbobo therealbobo && \
    mkdir -p /home/therealbobo && chown -R therealbobo:therealbobo /home/therealbobo

USER therealbobo
WORKDIR /home/therealbobo
ARG HOME='/home/therealbobo'

COPY --chown=therealbobo . $HOME/dotfiles/

RUN bash -c '/home/therealbobo/dotfiles/restore_dotfiles.sh -d archlinux'
