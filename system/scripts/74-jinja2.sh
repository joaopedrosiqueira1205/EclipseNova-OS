#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/jinja2-3.1.6"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Jinja2 3.1.6"
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
    Jinja2

echo
echo "[OK] Jinja2 3.1.6 instalado."