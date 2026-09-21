#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Connectivity Check"
echo "======================================"

echo
echo "===== INTERFACES ====="
ip -brief link 2>/dev/null || true

echo
echo "===== ENDERECOS ====="
ip -brief address 2>/dev/null || true

echo
echo "===== ROTAS ====="
ip route 2>/dev/null || true

echo
echo "===== DNS ====="
if command -v resolvectl >/dev/null 2>&1; then
    resolvectl status 2>/dev/null || true
else
    cat /etc/resolv.conf 2>/dev/null || true
fi

echo
echo "[OK] Diagnostico concluido."