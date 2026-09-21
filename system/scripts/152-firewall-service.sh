#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Firewall Service"
echo "======================================"

cat > /etc/systemd/system/eclipsenova-firewall.service << "EOF"
[Unit]
Description=EclipseNova OS Firewall
DefaultDependencies=no
Before=network-pre.target
Wants=network-pre.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/iptables-restore /etc/eclipsenova/firewall/iptables.rules
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable eclipsenova-firewall.service

echo "[OK] Firewall habilitado."