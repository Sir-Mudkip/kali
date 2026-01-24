#!/usr/bin/bash

set -eoux pipefail

# Install Brew and Brewfile
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/home/linuxbrew/.linuxbrew/bin/brew bundle --file=/usr/share/brewfiles/Brewfile 
/home/linuxbrew/.linuxbrew/bin/brew unlink util-linux

# Clean
rm -rf /usr/share/brewfiles
