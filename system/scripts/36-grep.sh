#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/grep-3.12"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Grep 3.12"
echo "======================================"

sed -i "s/echo/#echo/" src/egrep.sh

./configure --prefix=/usr

make -j1
make check
make install

echo
echo "[OK] Grep 3.12 instalado."