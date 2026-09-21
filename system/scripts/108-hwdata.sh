#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - hwdata"
echo "======================================"

if [ -d /usr/share/hwdata ]; then
    echo "[OK] /usr/share/hwdata existe."
else
    mkdir -pv /usr/share/hwdata
    echo "[OK] Diretorio hwdata preparado."
fi