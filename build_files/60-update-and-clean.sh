#!/usr/bin/bash
# clean.sh - Simple safe cleanup script
# Only removes caches and temporary files that are safe to delete

set -ouex pipefail

echo "======================================================"
echo "  Simple Container Cleanup Script"
echo "  Safe cleanup - won't break tools or man pages"
echo "======================================================"
echo ""

echo "======================================================"
echo " Updating Container - Ensure APT and Brew are updated "
echo "======================================================"
apt update && apt upgrade -y

# =============================================================================
# REMOVE KALI REPOSITORIES (if present)
# =============================================================================
echo "[2/6] Removing Kali repositories..."

rm -f /etc/apt/sources.list.d/kali.list 2>/dev/null || true
sed -i '/kali/d' /etc/apt/sources.list 2>/dev/null || true

echo "  ✓ Kali repos removed"

# =============================================================================
# PACKAGE MANAGER CACHES
# =============================================================================
echo "[3/6] Cleaning package manager caches..."

apt-get clean
apt-get autoclean
apt-get autoremove -y --purge

rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/apt/archives/*
rm -rf /var/cache/apt/*.bin

echo "  ✓ Package manager caches cleaned"

# =============================================================================
# TEMPORARY FILES
# =============================================================================
echo "[4/6] Cleaning temporary files..."

rm -rf /tmp/*
rm -rf /var/tmp/*

echo "  ✓ Temporary files cleaned"

# =============================================================================
# LOGS
# =============================================================================
echo "[5/6] Cleaning logs..."

rm -rf /var/log/*
mkdir -p /var/log

echo "  ✓ Logs cleaned"

# =============================================================================
# BUILD CACHES (safe ones only)
# =============================================================================
echo "[6/6] Cleaning build tool caches..."

# Pip download cache (NOT installed packages or bytecode)
rm -rf /root/.cache/pip 2>/dev/null || true
rm -rf /home/*/.cache/pip 2>/dev/null || true

# Gem cache
rm -rf /var/lib/gems/*/cache 2>/dev/null || true

# NPM cache
rm -rf /root/.npm 2>/dev/null || true
rm -rf /home/*/.npm 2>/dev/null || true

# Remove Build Files Dir
rm -rf /build_files

echo "  ✓ Build tool caches cleaned"

# =============================================================================
# FINAL REPORT
# =============================================================================
echo ""
echo "======================================================"
echo "  Cleanup Complete!"
echo "======================================================"
