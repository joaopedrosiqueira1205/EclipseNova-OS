#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Personal Firewall"
echo "======================================"

command -v iptables >/dev/null || {
    echo "[ERRO] iptables nao instalado."
    exit 1
}

iptables -F
iptables -X
iptables -Z

iptables -t nat -F

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -i lo -j ACCEPT

iptables -A INPUT \
    -m conntrack \
    --ctstate ESTABLISHED,RELATED \
    -j ACCEPT

echo "[OK] Firewall aplicado."