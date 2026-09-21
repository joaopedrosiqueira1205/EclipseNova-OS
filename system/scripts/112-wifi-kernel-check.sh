#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Wi-Fi Kernel Check"
echo "======================================"

CONFIG="/boot/config-$(uname -r)"

if [ ! -f "$CONFIG" ]; then
    CONFIG="/proc/config.gz"
fi

echo "Interfaces:"
ip link 2>/dev/null || true

echo
echo "Dispositivos de rede PCI:"
lspci -nnk 2>/dev/null |
    grep -A3 -Ei "network|wireless|ethernet" || true

echo
echo "Modulos wireless:"
lsmod 2>/dev/null |
    grep -Ei "wifi|wlan|iwl|ath|rtw|brcm" || true

echo
echo "[OK] Verificacao concluida."