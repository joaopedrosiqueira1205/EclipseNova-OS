#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/automake-1.18.1"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Automake 1.18.1"
echo "======================================"

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/automake-1.18.1

make -j1

echo "[INFO] Executando testes..."
make -j1 check

make install

echo
echo "[OK] Automake 1.18.1 instalado."