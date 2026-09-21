#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS - Source Manager
# Referencia: LFS 13.1-systemd
# ==========================================

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$PROJECT_ROOT/config/build-env.sh"

LFS_VERSION="13.1-systemd"
LFS_URL="https://www.linuxfromscratch.org/lfs/downloads/13.1-systemd"
SOURCE_DIR="$LFS/sources"

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Execute este script somente no Linux."
    exit 1
fi

mkdir -pv "$SOURCE_DIR"

echo
echo "======================================"
echo " SolarNexum Source Manager"
echo " LFS $LFS_VERSION"
echo "======================================"
echo

echo "[1/3] Baixando lista oficial e checksums..."

wget -O "$SOURCE_DIR/wget-list" \
    "$LFS_URL/wget-list"

wget -O "$SOURCE_DIR/md5sums" \
    "$LFS_URL/md5sums"

echo
echo "[2/3] Baixando fontes..."

wget \
    --input-file="$SOURCE_DIR/wget-list" \
    --continue \
    --directory-prefix="$SOURCE_DIR"

echo
echo "[3/3] Verificando integridade..."

cd "$SOURCE_DIR"

md5sum -c md5sums

echo
echo "======================================"
echo " [OK] Fontes baixadas e verificadas"
echo "======================================"