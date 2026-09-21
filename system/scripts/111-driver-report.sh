#!/usr/bin/env bash
set -euo pipefail

REPORT="/root/eclipsenova-drivers.txt"

echo "======================================"
echo " EclipseNova OS - Driver Report"
echo "======================================"

{
    echo "EclipseNova OS Driver Report"
    echo "Generated: $(date)"
    echo

    echo "===== PCI + DRIVERS ====="
    lspci -nnk 2>/dev/null || true

    echo
    echo "===== USB ====="
    lsusb 2>/dev/null || true

    echo
    echo "===== MODULES ====="
    lsmod 2>/dev/null || true

    echo
    echo "===== FIRMWARE MESSAGES ====="
    journalctl -k -b 2>/dev/null |
        grep -Ei "firmware|microcode|failed" || true

} > "$REPORT"

echo "[OK] Relatorio salvo em $REPORT"