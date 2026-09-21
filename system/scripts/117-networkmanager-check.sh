#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - NetworkManager Check"
echo "======================================"

ERRORS=0

check_pkg() {
    if pkg-config --exists "$1" 2>/dev/null; then
        echo "[OK] $1"
    else
        echo "[PENDENTE] $1"
        ERRORS=$((ERRORS + 1))
    fi
}

check_pkg libndp
check_pkg libcurl
check_pkg libpsl

if command -v wpa_supplicant >/dev/null 2>&1; then
    echo "[OK] wpa_supplicant"
else
    echo "[PENDENTE] wpa_supplicant"
    ERRORS=$((ERRORS + 1))
fi

echo
if [ "$ERRORS" -eq 0 ]; then
    echo "[OK] Base pronta para NetworkManager."
else
    echo "[INFO] Faltam $ERRORS dependencia(s)."
fi