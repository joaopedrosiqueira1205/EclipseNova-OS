#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/file-5.48"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - File 5.48"
echo "======================================"

./configure --prefix=/usr

make -j1
make check
make install

echo
echo "[OK] File 5.48 instalado."