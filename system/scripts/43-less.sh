#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/less-704"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Less 704"
echo "======================================"

./configure --prefix=/usr --sysconfdir=/etc

make -j1
make check
make install

echo
echo "[OK] Less 704 instalado."