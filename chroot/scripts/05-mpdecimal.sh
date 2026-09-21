#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - mpdecimal temporario
# LFS 13.1-systemd
# ==========================================

echo
echo "======================================"
echo " SolarNexum - mpdecimal Temporario"
echo "======================================"
echo

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

SOURCE="/sources/mpdecimal-4.0.1"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do mpdecimal 4.0.1 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando mpdecimal..."

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/mpdecimal-4.0.1

echo
echo "[2/3] Compilando mpdecimal..."

make -j1

echo
echo "[3/3] Instalando mpdecimal..."

make install

echo
echo "======================================"
echo " [OK] mpdecimal 4.0.1 temporario concluido"
echo "======================================"