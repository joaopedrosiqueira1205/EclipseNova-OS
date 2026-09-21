#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/attr-2.6.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Attr 2.6.0"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --sysconfdir=/etc \
    --docdir=/usr/share/doc/attr-2.6.0

make -j1
make check
make install

echo
echo "[OK] Attr 2.6.0 instalado."