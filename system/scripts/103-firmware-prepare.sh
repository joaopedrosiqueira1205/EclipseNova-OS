#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute como root."
    exit 1
fi

echo "======================================"
echo " EclipseNova OS - Firmware Preparation"
echo "======================================"

mkdir -pv /usr/lib/firmware

if [ ! -e /lib/firmware ]; then
    mkdir -pv /lib
    ln -sv /usr/lib/firmware /lib/firmware
fi

echo
echo "[OK] Estrutura de firmware preparada."

ls -ld /usr/lib/firmware