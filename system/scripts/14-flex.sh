#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/flex-2.6.4"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Flex 2.6.4"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/flex-2.6.4

make -j1
make check
make install

ln -sv flex /usr/bin/lex
ln -sv flex.1 /usr/share/man/man1/lex.1

echo
echo "[OK] Flex 2.6.4 instalado."