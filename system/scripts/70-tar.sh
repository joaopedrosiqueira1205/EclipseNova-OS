#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/tar-1.35"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Tar 1.35"
echo "======================================"

patch -Np1 -i ../tar-1.35-acl_fix-1.patch

FORCE_UNSAFE_CONFIGURE=1 \
./configure --prefix=/usr

make -j1
make check
make install

make -C doc install-html \
    docdir=/usr/share/doc/tar-1.35

echo
echo "[OK] Tar 1.35 instalado."