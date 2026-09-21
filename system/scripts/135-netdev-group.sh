#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - netdev Group"
echo "======================================"

if getent group netdev >/dev/null 2>&1; then
    echo "[OK] Grupo netdev ja existe."
else
    groupadd -g 86 netdev
    echo "[OK] Grupo netdev criado."
fi

echo
getent group netdev