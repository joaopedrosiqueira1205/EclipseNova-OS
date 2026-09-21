#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Hostname"
echo "======================================"

echo "solarnexum" > /etc/hostname

echo
echo "[OK] Hostname configurado:"
cat /etc/hostname