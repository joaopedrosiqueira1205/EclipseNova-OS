#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - NetworkManager Deps"
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

check_cmd() {
    if command -v "$1" >/dev/null 2>&1; then
        echo "[OK] $1"
    else
        echo "[PENDENTE] $1"
        ERRORS=$((ERRORS + 1))
    fi
}

check_pkg libndp
check_pkg libcurl
check_pkg libpsl

check_cmd wpa_supplicant
check_cmd meson
check_cmd ninja

echo
echo "Pendencias encontradas: $ERRORS"

exit "$ERRORS"