#!/usr/bin/bash

set -eoux pipefail

# Tools Packages
apt update && apt upgrade -y
DEBIAN_FRONTEND=noninteractive apt -y install \
    $(cat /build_files/tools | xargs)
rm -rd /var/lib/apt/lists/*

# Locales
sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
dpkg-reconfigure --frontend=noninteractive locales && \
update-locale LANG=en_GB.UTF-8

# hide login
touch ~/.hushlogin

# Ignore case on tab completion
echo "set completion ignore-case On" >> /etc/inputrc

# Brew and Manual Installs
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

/build_files/20-brew.sh
/build_files/30-git-installs.sh
