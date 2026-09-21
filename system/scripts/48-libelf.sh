#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/elfutils-0.195"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Libelf 0.195"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-debuginfod \
    --enable-libdebuginfod=dummy

make -j1 -C lib
make -j1 -C libelf

echo "[INFO] Executando testes..."
make -k check

make -C libelf install

install -vm644 config/libelf.pc /usr/lib/pkgconfig

rm -fv /usr/lib/libelf.a

echo
echo "[OK] Libelf 0.195 instalado."