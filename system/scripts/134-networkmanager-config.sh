#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - NetworkManager Config"
echo "======================================"

mkdir -pv /etc/NetworkManager/conf.d

cat > /etc/NetworkManager/NetworkManager.conf << "EOF"
[main]
plugins=keyfile
EOF

cat > /etc/NetworkManager/conf.d/eclipsenova.conf << "EOF"
[main]
auth-polkit=true

[connection]
wifi.powersave=2
EOF

mkdir -pv /etc/NetworkManager/system-connections
chmod 700 /etc/NetworkManager/system-connections

echo "[OK] NetworkManager configurado."