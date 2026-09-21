#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/gdbm-1.26"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - GDBM 1.26"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --enable-libgdbm-compat

make -j1
make check
make install

echo
echo "[OK] GDBM 1.26 instalado."