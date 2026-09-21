#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Wi-Fi Check"
echo "======================================"

if command -v iw >/dev/null 2>&1; then
    echo "===== PHY ====="
    iw phy 2>/dev/null || true

    echo
    echo "===== INTERFACES ====="
    iw dev 2>/dev/null || true
else
    echo "[PENDENTE] iw nao encontrado."
fi

echo
echo "===== RFKILL ====="

if command -v rfkill >/dev/null 2>&1; then
    rfkill list || true
else
    echo "[INFO] rfkill ainda nao instalado."
fi