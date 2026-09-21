#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/lz4-1.10.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Lz4 1.10.0"
echo "======================================"

make -j1 BUILD_STATIC=no PREFIX=/usr

make -j1 check

make BUILD_STATIC=no PREFIX=/usr install

echo
echo "[OK] Lz4 1.10.0 instalado."