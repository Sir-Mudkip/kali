#!/usr/bin/bash

set -eoux pipefail

# Tools Packages
apt update && apt upgrade -y
DEBIAN_FRONTEND=noninteractive apt -y install \
    $(cat /build_files/tools | xargs)
rm -rd /var/lib/apt/lists/*
