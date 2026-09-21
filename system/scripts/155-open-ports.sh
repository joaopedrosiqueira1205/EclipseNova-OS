#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Open Ports"
echo "======================================"

if command -v ss >/dev/null 2>&1; then
    echo
    echo "===== TCP/UDP LISTEN ====="
    ss -tulpen
else
    echo "[ERRO] comando ss nao encontrado."
    exit 1
fi

echo
echo "[OK] Auditoria concluida."