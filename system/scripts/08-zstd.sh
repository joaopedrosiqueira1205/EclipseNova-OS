#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/zstd-1.5.7"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Zstd 1.5.7"
echo "======================================"

make -j1 prefix=/usr
make -j1 check
make prefix=/usr install

rm -v /usr/lib/libzstd.a

echo
echo "[OK] Zstd 1.5.7 instalado."