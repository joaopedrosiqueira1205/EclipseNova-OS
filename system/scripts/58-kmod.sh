#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/kmod-34.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Kmod 34.2"
echo "======================================"

rm -rf build
mkdir -p build
cd build

meson setup \
    --prefix=/usr \
    --buildtype=release \
    -D manpages=false \
    ..

ninja -j1
ninja install

echo
echo "[OK] Kmod 34.2 instalado."