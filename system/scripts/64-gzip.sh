#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/gzip-1.14"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Gzip 1.14"
echo "======================================"

./configure --prefix=/usr

make -j1
make check
make install

echo
echo "[OK] Gzip 1.14 instalado."