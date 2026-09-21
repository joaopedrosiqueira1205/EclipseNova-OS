#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/linux-7.1.8"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Linux 7.1.8"
echo " Preparacao do Kernel"
echo "======================================"

make mrproper
make defconfig

echo
echo "[OK] Configuracao inicial criada."
echo "[INFO] Arquivo gerado: $SOURCE/.config"