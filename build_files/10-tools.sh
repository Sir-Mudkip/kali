#!/usr/bin/bash

set -eoux pipefail

# Tools Packages
apt update && apt upgrade -y
DEBIAN_FRONTEND=noninteractive apt -y install \
    $(cat tools | xargs)
rm -rd /var/lib/apt/lists/*

./20-brew.sh
./30-git-installs.sh
./60-update-and-clean.sh
