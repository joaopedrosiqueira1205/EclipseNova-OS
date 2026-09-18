#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " SolarNexum Source Manager 0.1"
echo "======================================"

SOURCE_DIR="${LFS:-/mnt/lfs}/sources"
LFS_FILES="https://www.linuxfromscratch.org/lfs/downloads/stable-systemd"

mkdir -p "$SOURCE_DIR"

echo "[1/3] Obtendo lista oficial..."
wget -O "$SOURCE_DIR/wget-list" "$LFS_FILES/wget-list"
wget -O "$SOURCE_DIR/md5sums" "$LFS_FILES/md5sums"

echo "[2/3] Baixando fontes..."
wget \
    --input-file="$SOURCE_DIR/wget-list" \
    --continue \
    --directory-prefix="$SOURCE_DIR"

echo "[3/3] Verificando integridade..."

cd "$SOURCE_DIR"

if md5sum -c md5sums; then
    echo
    echo "[OK] Todas as fontes foram verificadas."
else
    echo
    echo "[ERRO] Falha na verificacao das fontes."
    exit 1
fi

echo
echo "SolarNexum Source Manager concluido."