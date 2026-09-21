#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/mpc-1.4.1"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - MPC 1.4.1"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/mpc-1.4.1

make -j1
make html
make check

make install
make install-html

echo
echo "[OK] MPC 1.4.1 instalado."