#!/usr/bin/env bash
set -euo pipefail

REPORT="/root/eclipsenova-network.txt"

echo "======================================"
echo " EclipseNova OS - Network Report"
echo "======================================"

{
    echo "EclipseNova OS Network Report"
    echo "Generated: $(date)"
    echo

    echo "===== LINKS ====="
    ip -brief link 2>/dev/null || true

    echo
    echo "===== ADDRESSES ====="
    ip -brief address 2>/dev/null || true

    echo
    echo "===== ROUTES ====="
    ip route 2>/dev/null || true

    echo
    echo "===== WIFI ====="
    iw dev 2>/dev/null || true

    echo
    echo "===== DNS ====="
    resolvectl status 2>/dev/null || true

    echo
    echo "===== PCI NETWORK ====="
    lspci -nnk 2>/dev/null |
        grep -A3 -Ei "network|ethernet|wireless" || true

    echo
    echo "===== NETWORK SERVICES ====="
    systemctl --no-pager status \
        NetworkManager.service \
        systemd-networkd.service \
        systemd-resolved.service \
        2>/dev/null || true

} > "$REPORT"

echo "[OK] Relatorio criado:"
echo "$REPORT"