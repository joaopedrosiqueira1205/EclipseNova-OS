#!/usr/bin/env bash
set -euo pipefail

REPORT="/root/eclipsenova-security.txt"

echo "======================================"
echo " EclipseNova OS - Security Report"
echo "======================================"

{
    echo "EclipseNova OS Security Report"
    echo "Generated: $(date)"
    echo

    echo "===== FIREWALL ====="
    iptables -L -n -v 2>/dev/null || true

    echo
    echo "===== LISTENING PORTS ====="
    ss -tulpen 2>/dev/null || true

    echo
    echo "===== ENABLED SERVICES ====="
    systemctl list-unit-files \
        --type=service \
        --state=enabled 2>/dev/null || true

    echo
    echo "===== FAILED SERVICES ====="
    systemctl --failed --no-pager 2>/dev/null || true

    echo
    echo "===== FAILED LOGINS ====="
    journalctl -b 2>/dev/null |
        grep -Ei "authentication failure|failed password" |
        tail -50 || true

} > "$REPORT"

chmod 600 "$REPORT"

echo "[OK] Relatorio criado:"
echo "$REPORT"