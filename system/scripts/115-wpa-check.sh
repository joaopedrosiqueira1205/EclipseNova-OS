#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - WPA Check"
echo "======================================"

ERRORS=0

for cmd in pkg-config make gcc; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "[OK] $cmd"
    else
        echo "[ERRO] $cmd"
        ERRORS=$((ERRORS + 1))
    fi
done

if pkg-config --exists libnl-3.0 2>/dev/null; then
    echo "[OK] libnl"
else
    echo "[PENDENTE] libnl"
    ERRORS=$((ERRORS + 1))
fi

if [ "$ERRORS" -gt 0 ]; then
    exit 1
fi

echo "[OK] Dependencias basicas verificadas."