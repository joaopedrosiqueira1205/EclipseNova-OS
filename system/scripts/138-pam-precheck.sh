#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - PAM Precheck"
echo "======================================"

for cmd in gcc make meson ninja pkg-config; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "[OK] $cmd"
    else
        echo "[PENDENTE] $cmd"
    fi
done

echo
echo "[OK] Verificacao concluida."