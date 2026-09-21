#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/kbd-2.10.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Kbd 2.10.0"
echo "======================================"

patch -Np1 -i ../kbd-2.10.0-backspace-1.patch

sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

./configure \
    --prefix=/usr \
    --disable-vlock

make -j1
make check
make install

cp -R -v docs/doc \
    -T /usr/share/doc/kbd-2.10.0

echo
echo "[OK] Kbd 2.10.0 instalado."