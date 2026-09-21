#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/zlib-1.3.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Zlib 1.3.2"
echo "======================================"

./configure --prefix=/usr

make -j1
make check
make install

rm -fv /usr/lib/libz.a

echo
echo "[OK] Zlib 1.3.2 instalada."