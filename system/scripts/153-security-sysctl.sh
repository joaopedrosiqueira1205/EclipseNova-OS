#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Security Sysctl"
echo "======================================"

mkdir -pv /etc/sysctl.d

cat > /etc/sysctl.d/60-eclipsenova-security.conf << "EOF"
# EclipseNova OS security defaults

net.ipv4.icmp_echo_ignore_broadcasts = 1

net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.default.accept_source_route = 0

net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0

net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0

net.ipv4.tcp_syncookies = 1

kernel.randomize_va_space = 2
EOF

sysctl --system

echo "[OK] Parametros de seguranca aplicados."