#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Texinfo temporario
# LFS 13.1-systemd
# ==========================================

echo
echo "======================================"
echo " SolarNexum - Texinfo Temporario"
echo "======================================"
echo

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

SOURCE="/sources/texinfo-7.3"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Texinfo 7.3 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Texinfo..."

./configure --prefix=/usr

echo
echo "[2/3] Compilando Texinfo..."

make -j1

echo
echo "[3/3] Instalando Texinfo..."

make install

echo
echo "======================================"
echo " [OK] Texinfo 7.3 temporario concluido"
echo "======================================"