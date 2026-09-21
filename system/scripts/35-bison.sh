#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/bison-3.8.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Bison 3.8.2"
echo "======================================"

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/bison-3.8.2

make -j1
make check
make install

echo
echo "[OK] Bison 3.8.2 instalado."