#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Zlib temporario
# LFS 13.1-systemd
# ==========================================

echo
echo "======================================"
echo " SolarNexum - Zlib Temporario"
echo "======================================"
echo

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

SOURCE="/sources/zlib-1.3.2"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Zlib 1.3.2 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Zlib..."

./configure --prefix=/usr

echo
echo "[2/3] Compilando Zlib..."

make -j1

echo
echo "[3/3] Instalando Zlib..."

make install

# Arquivos libtool/estaticos nao sao necessarios
rm -fv /usr/lib/libz.a

echo
echo "======================================"
echo " [OK] Zlib 1.3.2 temporario concluido"
echo "======================================"