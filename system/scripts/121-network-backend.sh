#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Network Backend"
echo "======================================"

mkdir -pv /etc/eclipsenova

cat > /etc/eclipsenova/network.conf << "EOF"
# EclipseNova OS Network Configuration

NETWORK_BACKEND=NetworkManager
WIFI_BACKEND=wpa_supplicant
DNS_BACKEND=systemd-resolved
EOF

echo "[OK] Backend de rede definido."
cat /etc/eclipsenova/network.conf