#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/patch-2.8"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Patch 2.8"
echo "======================================"

./configure --prefix=/usr

make -j1
make check
make install

echo
echo "[OK] Patch 2.8 instalado."