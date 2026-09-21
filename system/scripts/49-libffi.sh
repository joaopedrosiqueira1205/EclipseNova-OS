#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/libffi-3.8.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Libffi 3.8.0"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --with-gcc-arch=native

make -j1
make check
make install

echo
echo "[OK] Libffi 3.8.0 instalado."