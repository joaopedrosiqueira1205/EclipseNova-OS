#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Gettext temporario
# LFS 13.1-systemd
# ==========================================

echo
echo "======================================"
echo " SolarNexum - Gettext Temporario"
echo "======================================"
echo

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

SOURCE="/sources/gettext-0.26"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Gettext nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Gettext..."

./configure \
    --disable-shared

echo
echo "[2/3] Compilando ferramentas necessarias..."

make -C src msgfmt
make -C src msgmerge
make -C src xgettext

echo
echo "[3/3] Instalando ferramentas temporarias..."

cp -v src/{msgfmt,msgmerge,xgettext} /usr/bin

echo
echo "======================================"
echo " [OK] Gettext temporario concluido"
echo "======================================"