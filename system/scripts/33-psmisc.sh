#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/psmisc-23.7"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Psmisc 23.7"
echo "======================================"

./configure --prefix=/usr

make -j1
make check
make install

echo
echo "[OK] Psmisc 23.7 instalado."