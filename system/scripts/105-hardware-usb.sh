#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - USB Hardware"
echo "======================================"

if command -v lsusb >/dev/null 2>&1; then
    lsusb
else
    echo "[AVISO] lsusb ainda nao esta instalado."
    echo "O pacote usbutils sera adicionado posteriormente."
fi