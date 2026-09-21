#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/m4-1.4.21"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - M4 1.4.21"
echo "======================================"

./configure --prefix=/usr

make -j1
make check
make install

echo
echo "[OK] M4 1.4.21 instalado."