#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/readline-8.3"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Readline 8.3"
echo "======================================"

sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

sed -i 's/-Wl,-rpath,[^ ]*//' support/shobj-conf

sed -e '270a\
     else\
       chars_avail = 1;'      \
    -e '288i\   result = -1;' \
    -i.orig input.c

./configure \
    --prefix=/usr \
    --disable-static \
    --with-curses \
    --docdir=/usr/share/doc/readline-8.3

make -j1 SHLIB_LIBS="-lncursesw"

make install

install -v -m644 doc/*.{ps,pdf,html,dvi} \
    /usr/share/doc/readline-8.3

echo
echo "[OK] Readline 8.3 instalado."