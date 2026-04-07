FROM docker.io/kalilinux/kali-rolling

ENV SHELL=/bin/bash
ENV LANG=en_GB.UTF-8

COPY dotfiles/shell/bashrc /root/.bashrc
COPY dotfiles/shell/bashrc.d/ /root/.bashrc.d/
COPY dotfiles/bash-color-prompt.sh /etc/profile.d/
COPY dotfiles/nvim/ /root/.config/nvim/
COPY dotfiles/tmux.conf /root/.tmux.conf
COPY dotfiles/tmux/ /root/.tmux/
COPY build_files /build_files

RUN --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /build_files/00-tools.sh

RUN --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /build_files/05-manual-installs.sh

RUN --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /build_files/10-wordlist.sh

RUN --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /build_files/50-config.sh

RUN --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /build_files/60-update-and-clean.sh

WORKDIR /root
CMD /bin/bash
