#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/pkgconf-3.0.5"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Pkgconf 3.0.5"
echo "======================================"

rm -rf build meson-1.12.0

tar -xf ../meson-1.12.0.tar.gz

mkdir build
cd build

python3 ../meson-1.12.0/meson.py setup \
    --prefix=/usr \
    --buildtype=release ..

ninja -j1
ninja test
ninja install

mv /usr/share/doc/pkgconf{,-3.0.5}

ln -sv pkgconf /usr/bin/pkg-config
ln -sv pkgconf.1 /usr/share/man/man1/pkg-config.1

echo
echo "[OK] Pkgconf 3.0.5 instalado."