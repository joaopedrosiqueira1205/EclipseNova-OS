#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - libpsl Check"
echo "======================================"

if pkg-config --exists libpsl 2>/dev/null; then
    echo "[OK] libpsl encontrada."
    pkg-config --modversion libpsl
else
    echo "[ERRO] libpsl nao encontrada."
    exit 1
fi

if command -v psl >/dev/null 2>&1; then
    echo "[OK] comando psl encontrado."
else
    echo "[AVISO] comando psl nao encontrado."
fi