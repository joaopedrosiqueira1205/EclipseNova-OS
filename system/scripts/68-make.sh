#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/make-4.4.1"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Make 4.4.1"
echo "======================================"

./configure --prefix=/usr

make -j1

chown -R tester .
su tester -c "PATH=$PATH make check"

make install

echo
echo "[OK] Make 4.4.1 instalado."