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

# Neovim Plugin Configs
mkdir -p /root/.local/share/nvim/site/pack/plugins/start && \
cd /root/.local/share/nvim/site/pack/plugins/start && \
git clone --depth 1 https://github.com/nvim-lua/plenary.nvim && \
git clone --depth 1 https://github.com/nvim-telescope/telescope.nvim && \
git clone --depth 1 https://github.com/catppuccin/nvim catppuccin && \
git clone --depth 1 https://github.com/nvim-tree/nvim-web-devicons && \
git clone --depth 1 https://github.com/nvim-neo-tree/neo-tree.nvim && \
git clone --depth 1 https://github.com/MunifTanjim/nui.nvim
