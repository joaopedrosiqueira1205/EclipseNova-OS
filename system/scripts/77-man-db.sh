#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/man-db-2.13.1"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Man-DB 2.13.1"
echo "======================================"

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/man-db-2.13.1 \
    --sysconfdir=/etc \
    --disable-setuid \
    --enable-cache-owner=bin \
    --with-browser=/usr/bin/lynx \
    --with-vgrind=/usr/bin/vgrind \
    --with-grap=/usr/bin/grap

make -j1
make check
make install

echo
echo "[OK] Man-DB 2.13.1 instalado."