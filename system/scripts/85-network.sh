#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Network"
echo "======================================"

mkdir -pv /etc/systemd/network

cat > /etc/systemd/network/20-wired.network << "EOF"
[Match]
Type=ether

[Network]
DHCP=yes
EOF

systemctl enable systemd-networkd.service
systemctl enable systemd-resolved.service

ln -sfv /run/systemd/resolve/stub-resolv.conf \
    /etc/resolv.conf

echo
echo "[OK] Rede Ethernet DHCP preparada."
echo "[INFO] Wi-Fi sera configurado posteriormente."