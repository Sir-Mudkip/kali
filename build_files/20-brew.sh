#!/usr/bin/bash

set -eoux pipefail

# Install Brew and Brewfile
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/home/linuxbrew/.linuxbrew/bin/brew bundle --file=/build_files/Brewfile 
/home/linuxbrew/.linuxbrew/bin/brew unlink util-linux

# Clean
rm -rf /build_files/Brewfiles
