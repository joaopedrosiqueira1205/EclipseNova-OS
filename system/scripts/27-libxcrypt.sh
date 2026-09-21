#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/libxcrypt-4.5.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Libxcrypt 4.5.2"
echo "======================================"

# Correcao necessaria para Glibc 2.43 ou superior.
sed -i '/strchr/s/const//' lib/crypt-{sm3,gost}-yescrypt.c

./configure \
    --prefix=/usr \
    --enable-hashes=strong,glibc \
    --enable-obsolete-api=no \
    --disable-static \
    --disable-failure-tokens

make -j1
make check
make install

echo
echo "[OK] Libxcrypt 4.5.2 instalado."