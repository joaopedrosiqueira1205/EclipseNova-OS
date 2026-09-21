#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/texinfo-7.3"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Texinfo 7.3"
echo "======================================"

./configure --prefix=/usr

make -j1
make check
make install

echo
echo "[OK] Texinfo 7.3 instalado."