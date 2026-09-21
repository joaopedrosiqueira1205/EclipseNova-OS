#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - PCI Hardware"
echo "======================================"

if command -v lspci >/dev/null 2>&1; then
    lspci -nn
else
    echo "[AVISO] lspci ainda nao esta instalado."
    echo "O pacote pciutils sera adicionado posteriormente."
fi