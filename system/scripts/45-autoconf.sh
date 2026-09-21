#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/autoconf-2.73"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Autoconf 2.73"
echo "======================================"

./configure --prefix=/usr

make -j1
make check
make install

echo
echo "[OK] Autoconf 2.73 instalado."