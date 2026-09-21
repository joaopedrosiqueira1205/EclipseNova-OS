#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/binutils-2.47"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Binutils 2.47"
echo "======================================"

rm -rf build
mkdir -v build
cd build

../configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --enable-ld=default \
    --enable-plugins \
    --enable-shared \
    --disable-werror \
    --enable-64-bit-bfd \
    --enable-new-dtags \
    --with-system-zlib \
    --with-lib-path=/usr/lib \
    --enable-default-hash-style=gnu

make -j1 tooldir=/usr

echo
echo "[IMPORTANTE] Executando testes criticos do Binutils..."

make -k check

echo
echo "[INFO] Falhas encontradas:"
grep '^FAIL:' $(find -name '*.log') || true

make tooldir=/usr install

rm -rfv \
    /usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a \
    /usr/share/doc/gprofng/

echo
echo "[OK] Binutils 2.47 instalado."