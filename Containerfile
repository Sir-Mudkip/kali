FROM docker.io/kalilinux/kali-rolling

ENV SHELL=/bin/bash
ENV LANG=en_GB.UTF-8

COPY config/bashrc /root/.bashrc
COPY config/aliases /root/.bashrc.d/
COPY config/bash-color-prompt.sh /etc/profile.d/
COPY config/nvim /root/.config/nvim
COPY config/tmux.conf /root/.tmux.conf
COPY config/tmux/ /root/.tmux/
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
