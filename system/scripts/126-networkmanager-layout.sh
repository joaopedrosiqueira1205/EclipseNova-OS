#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - NetworkManager Layout"
echo "======================================"

mkdir -pv /etc/NetworkManager
mkdir -pv /etc/NetworkManager/conf.d
mkdir -pv /etc/NetworkManager/system-connections

chmod 700 /etc/NetworkManager/system-connections

cat > /etc/NetworkManager/conf.d/eclipsenova.conf << "EOF"
[main]
plugins=keyfile

[connection]
wifi.powersave=2
EOF

echo "[OK] Estrutura preparada."