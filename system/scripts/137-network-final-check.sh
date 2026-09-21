#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Network Final Check"
echo "======================================"

ERRORS=0

for cmd in ip iw curl wpa_supplicant; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "[OK] $cmd"
    else
        echo "[PENDENTE] $cmd"
        ERRORS=$((ERRORS + 1))
    fi
done

if command -v nmcli >/dev/null 2>&1; then
    echo "[OK] nmcli"
    nmcli general status 2>/dev/null || true
else
    echo "[PENDENTE] NetworkManager/nmcli"
    ERRORS=$((ERRORS + 1))
fi

echo
ip -brief link 2>/dev/null || true

echo
if [ "$ERRORS" -eq 0 ]; then
    echo "[OK] Camada principal de rede operacional."
else
    echo "[INFO] Ainda existem $ERRORS pendencia(s)."
fi