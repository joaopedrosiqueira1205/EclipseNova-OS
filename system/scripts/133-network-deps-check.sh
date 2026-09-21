#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Network Dependencies"
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

check_pkg libnl-3.0
check_pkg libnl-genl-3.0
check_pkg libndp
check_pkg libpsl
check_pkg libcurl

check_cmd iw
check_cmd wpa_supplicant
check_cmd curl

echo
echo "Pendencias: $ERRORS"

if [ "$ERRORS" -gt 0 ]; then
    exit 1
fi

echo "[OK] Dependencias principais presentes."