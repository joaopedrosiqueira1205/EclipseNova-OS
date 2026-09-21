#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/findutils-4.11.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Findutils 4.11.0"
echo "======================================"

./configure \
    --prefix=/usr \
    --localstatedir=/var/lib/locate

make -j1

chown -R tester .
su tester -c "PATH=$PATH make check -k"

make install

echo
echo "[OK] Findutils 4.11.0 instalado."