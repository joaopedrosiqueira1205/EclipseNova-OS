#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/ncurses-6.6"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Ncurses 6.6"
echo "======================================"

./configure \
    --prefix=/usr \
    --mandir=/usr/share/man \
    --with-shared \
    --without-debug \
    --without-normal \
    --with-cxx-shared \
    --enable-pc-files \
    --with-pkg-config-libdir=/usr/lib/pkgconfig

make -j1

rm -rf dest
make DESTDIR="$PWD/dest" install

sed -e 's/^#if.*XOPEN.*$/#if 1/' \
    -i dest/usr/include/curses.h

cp --remove-destination -av dest/* /

for lib in ncurses form panel menu; do
    ln -sfv "lib${lib}w.so" "/usr/lib/lib${lib}.so"
    ln -sfv "${lib}w.pc" "/usr/lib/pkgconfig/${lib}.pc"
done

ln -sfv libncursesw.so /usr/lib/libcurses.so

cp -v -R doc -T /usr/share/doc/ncurses-6.6

echo
echo "[OK] Ncurses 6.6 instalado."