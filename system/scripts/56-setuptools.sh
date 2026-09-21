#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/setuptools-84.0.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Setuptools 84.0.0"
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
    setuptools

echo
echo "[OK] Setuptools 84.0.0 instalado."