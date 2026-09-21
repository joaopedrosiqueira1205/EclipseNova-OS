#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/packaging-26.3"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Packaging 26.3"
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
    packaging

echo
echo "[OK] Packaging 26.3 instalado."