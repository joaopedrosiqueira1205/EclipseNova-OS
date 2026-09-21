#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - NetworkManager Precheck"
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
check_pkg glib-2.0

if command -v wpa_supplicant >/dev/null 2>&1; then
    echo "[OK] wpa_supplicant"
else
    echo "[PENDENTE] wpa_supplicant"
    ERRORS=$((ERRORS + 1))
fi

if command -v polkitd >/dev/null 2>&1; then
    echo "[OK] polkit"
else
    echo "[PENDENTE] polkit"
    ERRORS=$((ERRORS + 1))
fi

echo
echo "Pendencias: $ERRORS"