#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Polkit Precheck"
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

check_pkg glib-2.0

if command -v duktape >/dev/null 2>&1 ||
   pkg-config --exists duktape 2>/dev/null; then
    echo "[OK] duktape"
else
    echo "[PENDENTE] duktape"
    ERRORS=$((ERRORS + 1))
fi

echo
echo "Pendencias: $ERRORS"