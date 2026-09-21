#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/bzip2-1.0.8"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Bzip2 1.0.8"
echo "======================================"

patch -Np1 -i ../bzip2-1.0.8-install_docs-1.patch

sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

make -f Makefile-libbz2_so
make clean

make -j1
make PREFIX=/usr install

cp -av libbz2.so.* /usr/lib

ln -sfv libbz2.so.1.0.8 /usr/lib/libbz2.so
ln -sfv libbz2.so.1.0.8 /usr/lib/libbz2.so.1

cp -v bzip2-shared /usr/bin/bzip2

for i in /usr/bin/{bzcat,bunzip2}; do
    ln -sfv bzip2 "$i"
done

rm -fv /usr/lib/libbz2.a

echo
echo "[OK] Bzip2 1.0.8 instalado."