#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/dbus-1.16.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - D-Bus 1.16.2"
echo "======================================"

rm -rf build
mkdir build
cd build

meson setup \
    --prefix=/usr \
    --buildtype=release \
    --wrap-mode=nofallback \
    ..

ninja -j1
ninja test
ninja install

ln -sfv /etc/machine-id /var/lib/dbus

echo
echo "[OK] D-Bus 1.16.2 instalado."