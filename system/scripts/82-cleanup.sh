#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Chapter 8 Cleanup"
echo "======================================"

echo "[INFO] Removendo arquivos temporarios..."

rm -rf /tmp/*
rm -rf /var/tmp/*

find /usr/lib /usr/libexec \
    -name \*.la \
    -delete

find /usr \
    -depth \
    -name "$(uname -m)-lfs-linux-gnu*" \
    -delete 2>/dev/null || true

echo
echo "[OK] Limpeza do Chapter 8 concluida."