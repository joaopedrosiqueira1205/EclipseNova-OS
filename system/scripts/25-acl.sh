#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/acl-2.4.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Acl 2.4.0"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --docdir=/usr/share/doc/acl-2.4.0

make -j1

echo "[INFO] Executando testes..."
make check

make install

echo
echo "[OK] Acl 2.4.0 instalado."