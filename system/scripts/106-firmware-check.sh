#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Firmware Check"
echo "======================================"

echo
echo "Procurando mensagens relacionadas a firmware..."
echo

if command -v journalctl >/dev/null 2>&1; then
    journalctl -k -b 2>/dev/null |
        grep -Ei "firmware|failed to load" || true
else
    dmesg 2>/dev/null |
        grep -Ei "firmware|failed to load" || true
fi

echo
echo "[OK] Verificacao concluida."