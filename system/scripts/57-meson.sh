#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/meson-1.12.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Meson 1.12.0"
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
    meson

install -vDm644 \
    data/shell-completions/bash/meson \
    /usr/share/bash-completion/completions/meson

install -vDm644 \
    data/shell-completions/zsh/_meson \
    /usr/share/zsh/site-functions/_meson

echo
echo "[OK] Meson 1.12.0 instalado."