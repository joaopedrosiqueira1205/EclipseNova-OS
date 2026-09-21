#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/inetutils-2.8"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Inetutils 2.8"
echo "======================================"

sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c

./configure \
    --prefix=/usr \
    --bindir=/usr/bin \
    --localstatedir=/var \
    --disable-logger \
    --disable-whois \
    --disable-rcp \
    --disable-rexec \
    --disable-rlogin \
    --disable-rsh \
    --disable-servers

make -j1
make check
make install

mv -v /usr/{,s}bin/ifconfig

echo
echo "[OK] Inetutils 2.8 instalado."