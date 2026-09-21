#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Python temporario
# LFS 13.1-systemd
# ==========================================

echo
echo "======================================"
echo " SolarNexum - Python Temporario"
echo "======================================"
echo

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

SOURCE="/sources/Python-3.14.7"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Python 3.14.7 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Python..."

./configure \
    --prefix=/usr \
    --enable-shared \
    --without-ensurepip \
    --without-static-libpython

echo
echo "[2/3] Compilando Python..."

make -j1

echo
echo "[3/3] Instalando Python..."

make install

echo
echo "======================================"
echo " [OK] Python 3.14.7 temporario concluido"
echo "======================================"