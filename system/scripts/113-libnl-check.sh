#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - libnl Check"
echo "======================================"

if pkg-config --exists libnl-3.0 2>/dev/null; then
    echo "[OK] libnl-3 encontrado."
else
    echo "[PENDENTE] libnl ainda precisa ser instalado."
fi

if pkg-config --exists libnl-genl-3.0 2>/dev/null; then
    echo "[OK] libnl-genl encontrado."
else
    echo "[PENDENTE] libnl-genl ainda precisa ser instalado."
fi