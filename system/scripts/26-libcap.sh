#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/libcap-2.78"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Libcap 2.78"
echo "======================================"

sed -i '/install -m.*STA/d' libcap/Makefile

make -j1 prefix=/usr lib=lib

make test

make prefix=/usr lib=lib install

echo
echo "[OK] Libcap 2.78 instalado."