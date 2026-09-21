#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/util-linux-2.42.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Util-linux 2.42.2"
echo "======================================"

./configure \
    --bindir=/usr/bin \
    --libdir=/usr/lib \
    --runstatedir=/run \
    --sbindir=/usr/sbin \
    --disable-chfn-chsh \
    --disable-login \
    --disable-nologin \
    --disable-su \
    --disable-setpriv \
    --disable-runuser \
    --disable-pylibmount \
    --disable-liblastlog2 \
    --disable-static \
    --without-python \
    ADJTIME_PATH=/var/lib/hwclock/adjtime \
    --docdir=/usr/share/doc/util-linux-2.42.2

make -j1

echo "[INFO] Testes completos ficam para o sistema inicializado."

make install

echo
echo "[OK] Util-linux 2.42.2 instalado."