#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/groff-1.24.1"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Groff 1.24.1"
echo "======================================"

PAGE=A4 ./configure --prefix=/usr

make -j1

echo "[INFO] Executando testes..."
make check

make install

echo
echo "[OK] Groff 1.24.1 instalado."