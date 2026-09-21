#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/pcre2-10.47"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Pcre2 10.47"
echo "======================================"

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/pcre2-10.47 \
    --enable-unicode \
    --enable-jit \
    --enable-pcre2-16 \
    --enable-pcre2-32 \
    --enable-pcre2grep-libz \
    --enable-pcre2grep-libbz2 \
    --enable-pcre2test-libreadline \
    --disable-static

make -j1
make check
make install

echo
echo "[OK] Pcre2 10.47 instalado."