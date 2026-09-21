#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/bc-7.0.3"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Bc 7.0.3"
echo "======================================"

CC='gcc -std=c99' ./configure \
    --prefix=/usr \
    -G \
    -O3 \
    -r

make -j1
make test
make install

echo
echo "[OK] Bc 7.0.3 instalado."