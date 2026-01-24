#!/usr/bin/bash

set -eoux pipefail

# Tools Packages
apt update && apt upgrade -y
DEBIAN_FRONTEND=noninteractive apt -y install \
    $(cat tools | xargs)
rm -rd /var/lib/apt/lists/*

/build_files/20-brew.sh
/build_files/30-git-installs.sh
