#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Util-linux temporario
# LFS 13.1-systemd
# ==========================================

echo
echo "======================================"
echo " SolarNexum - Util-linux Temporario"
echo "======================================"
echo

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

SOURCE="/sources/util-linux-2.42.2"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Util-linux 2.42.2 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Util-linux..."

mkdir -pv /var/lib/hwclock

./configure \
    --libdir=/usr/lib \
    --runstatedir=/run \
    --disable-chfn-chsh \
    --disable-login \
    --disable-nologin \
    --disable-su \
    --disable-setpriv \
    --disable-runuser \
    --disable-pylibmount \
    --disable-static \
    --disable-liblastlog2 \
    --without-python \
    ADJTIME_PATH=/var/lib/hwclock/adjtime

echo
echo "[2/3] Compilando Util-linux..."

make -j1

echo
echo "[3/3] Instalando Util-linux..."

make install

echo
echo "======================================"
echo " [OK] Util-linux 2.42.2 temporario concluido"
echo "======================================"