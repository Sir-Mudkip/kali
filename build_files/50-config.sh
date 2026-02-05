#!/usr/bin/bash

set -eoux pipefail

# Locales
sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
dpkg-reconfigure --frontend=noninteractive locales && \
update-locale LANG=en_GB.UTF-8

# hide login
touch ~/.hushlogin

# Ignore case on tab completion
echo "set completion-ignore-case On" >> /etc/inputrc
