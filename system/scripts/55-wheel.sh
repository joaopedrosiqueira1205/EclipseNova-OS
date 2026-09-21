#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/wheel-0.48.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Wheel 0.48.0"
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
    wheel

echo
echo "[OK] Wheel 0.48.0 instalado."