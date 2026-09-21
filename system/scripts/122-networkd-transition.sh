#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Network Transition"
echo "======================================"

if systemctl is-enabled NetworkManager.service \
    >/dev/null 2>&1; then

    echo "[INFO] NetworkManager ativo."

    systemctl disable systemd-networkd.service \
        2>/dev/null || true

    systemctl disable systemd-networkd-wait-online.service \
        2>/dev/null || true

    echo "[OK] systemd-networkd desativado."
else
    echo "[INFO] NetworkManager ainda nao esta ativo."
    echo "Nenhuma alteracao realizada."
fi