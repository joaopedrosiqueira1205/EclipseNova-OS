#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 8 - Man-pages 6.18
# LFS 13.1-systemd
# ==========================================

SOURCE="/sources/man-pages-6.18"

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Este script deve ser executado no Linux."
    exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute este script dentro do chroot como root."
    exit 1
fi

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fonte nao encontrada:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Man-pages 6.18"
echo "======================================"

echo "[1/2] Removendo paginas substituidas pelo Libxcrypt..."
rm -v man3/crypt*

echo "[2/2] Instalando Man-pages..."
make -R GIT=false prefix=/usr install

echo
echo "[OK] Man-pages 6.18 instalado."