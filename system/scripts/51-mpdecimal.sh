#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/mpdecimal-4.0.1"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - mpdecimal 4.0.1"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/mpdecimal-4.0.1

make -j1

echo "[INFO] Executando testes..."
make check_local

make install

echo
echo "[OK] mpdecimal 4.0.1 instalado."