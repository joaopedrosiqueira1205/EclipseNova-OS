#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Bison temporario
# LFS 13.1-systemd
# ==========================================

echo
echo "======================================"
echo " SolarNexum - Bison Temporario"
echo "======================================"
echo

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

SOURCE="/sources/bison-3.8.2"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Bison 3.8.2 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Bison..."

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/bison-3.8.2

echo
echo "[2/3] Compilando Bison..."

make -j1

echo
echo "[3/3] Instalando Bison..."

make install

echo
echo "======================================"
echo " [OK] Bison 3.8.2 temporario concluido"
echo "======================================"