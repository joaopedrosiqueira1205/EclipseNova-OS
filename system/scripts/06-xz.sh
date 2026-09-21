#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/xz-5.8.3"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Xz 5.8.3"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/xz-5.8.3

make -j1
make check
make install

echo
echo "[OK] Xz 5.8.3 instalado."