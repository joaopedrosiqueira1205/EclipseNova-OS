#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/linux-7.1.8"
VERSION="7.1.8"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Kernel Install"
echo "======================================"

if [ ! -f arch/x86/boot/bzImage ]; then
    echo "[ERRO] Kernel ainda nao foi compilado."
    exit 1
fi

mkdir -pv /boot
mkdir -pv "/usr/share/doc/linux-$VERSION"

cp -iv arch/x86/boot/bzImage \
    "/boot/vmlinuz-$VERSION-solarnexum"

cp -iv System.map \
    "/boot/System.map-$VERSION"

cp -iv .config \
    "/boot/config-$VERSION"

cp -r Documentation \
    -T "/usr/share/doc/linux-$VERSION"

chown -R 0:0 "$SOURCE"

echo
echo "[OK] Kernel instalado:"
echo "/boot/vmlinuz-$VERSION-solarnexum"