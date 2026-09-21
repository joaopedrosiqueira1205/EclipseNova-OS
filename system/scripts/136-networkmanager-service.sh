#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - NetworkManager Service"
echo "======================================"

if ! systemctl list-unit-files NetworkManager.service \
    >/dev/null 2>&1; then
    echo "[ERRO] NetworkManager ainda nao esta instalado."
    exit 1
fi

systemctl disable systemd-networkd.service \
    2>/dev/null || true

systemctl disable systemd-networkd-wait-online.service \
    2>/dev/null || true

systemctl enable NetworkManager.service

systemctl disable NetworkManager-wait-online.service \
    2>/dev/null || true

echo "[OK] NetworkManager configurado para inicializacao."