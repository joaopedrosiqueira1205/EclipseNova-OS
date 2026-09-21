#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/linux-7.1.8"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Kernel Build"
echo " Linux 7.1.8"
echo "======================================"

if [ ! -f .config ]; then
    echo "[ERRO] Configuracao do kernel inexistente."
    exit 1
fi

echo "[INFO] Compilando com apenas 1 processo..."
make -j1

echo "[INFO] Instalando modulos..."
make modules_install

echo
echo "[OK] Kernel e modulos compilados."