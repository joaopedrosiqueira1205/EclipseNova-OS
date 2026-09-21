#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/diffutils-3.12"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Diffutils 3.12"
echo "======================================"

./configure --prefix=/usr

make -j1
make check
make install

echo
echo "[OK] Diffutils 3.12 instalado."