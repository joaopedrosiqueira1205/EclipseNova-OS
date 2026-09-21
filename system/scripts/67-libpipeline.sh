#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/libpipeline-1.5.8"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Libpipeline 1.5.8"
echo "======================================"

./configure --prefix=/usr

make -j1
make install

echo
echo "[OK] Libpipeline 1.5.8 instalado."