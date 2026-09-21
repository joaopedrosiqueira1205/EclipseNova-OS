#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/gettext-1.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Gettext 1.0"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/gettext-1.0

make -j1
make check
make install

chmod -v 0755 /usr/lib/preloadable_libintl.so

echo
echo "[OK] Gettext 1.0 instalado."