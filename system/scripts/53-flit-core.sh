#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/flit_core-4.0.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Flit-Core 4.0.2"
echo "======================================"

pip3 wheel \
    -w dist \
    --no-cache-dir \
    --no-build-isolation \
    --no-deps \
    "$PWD"

pip3 install \
    --no-index \
    --find-links dist \
    flit_core

echo
echo "[OK] Flit-Core 4.0.2 instalado."