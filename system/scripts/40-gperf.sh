#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/gperf-3.3"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Gperf 3.3"
echo "======================================"

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/gperf-3.3

make -j1
make check
make install

echo
echo "[OK] Gperf 3.3 instalado."