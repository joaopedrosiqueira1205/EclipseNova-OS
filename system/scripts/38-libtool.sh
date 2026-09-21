#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/libtool-2.6.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Libtool 2.6.2"
echo "======================================"

./configure --prefix=/usr

make -j1
make check
make install

rm -fv /usr/lib/libltdl.a

echo
echo "[OK] Libtool 2.6.2 instalado."