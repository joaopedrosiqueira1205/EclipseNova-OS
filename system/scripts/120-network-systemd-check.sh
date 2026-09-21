#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Network Systemd Check"
echo "======================================"

for service in \
    systemd-networkd.service \
    systemd-resolved.service
do
    if systemctl list-unit-files "$service" \
        >/dev/null 2>&1; then
        echo "[OK] $service encontrado."
    else
        echo "[INFO] $service nao encontrado."
    fi
done

echo
echo "Interfaces:"
ip -brief link 2>/dev/null || true

echo
echo "[OK] Verificacao concluida."