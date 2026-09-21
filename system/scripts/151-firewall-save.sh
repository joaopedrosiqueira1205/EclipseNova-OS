#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Save Firewall"
echo "======================================"

mkdir -pv /etc/eclipsenova/firewall

iptables-save > /etc/eclipsenova/firewall/iptables.rules

chmod 600 /etc/eclipsenova/firewall/iptables.rules

echo "[OK] Regras salvas."