#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/expat-2.8.3"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Expat 2.8.3"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/expat-2.8.3

make -j1
make check
make install

install -v -m644 doc/*.{html,css} \
    /usr/share/doc/expat-2.8.3

echo
echo "[OK] Expat 2.8.3 instalado."