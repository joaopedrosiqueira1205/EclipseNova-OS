#!/usr/bin/env bash
set -euo pipefail

REPORT="/root/eclipsenova-hardware.txt"

echo "======================================"
echo " EclipseNova OS - Hardware Report"
echo "======================================"

{
    echo "EclipseNova OS Hardware Report"
    echo "Generated: $(date)"
    echo

    echo "===== CPU ====="
    grep -E "model name|vendor_id|cpu cores" /proc/cpuinfo |
        sort -u || true

    echo
    echo "===== MEMORY ====="
    grep -E "MemTotal|MemAvailable|SwapTotal" /proc/meminfo || true

    echo
    echo "===== PCI ====="
    if command -v lspci >/dev/null 2>&1; then
        lspci -nn
    else
        echo "lspci unavailable"
    fi

    echo
    echo "===== USB ====="
    if command -v lsusb >/dev/null 2>&1; then
        lsusb
    else
        echo "lsusb unavailable"
    fi

    echo
    echo "===== NETWORK ====="
    ip link 2>/dev/null || true

    echo
    echo "===== BLOCK DEVICES ====="
    lsblk 2>/dev/null || true

    echo
    echo "===== KERNEL ====="
    uname -a

} > "$REPORT"

echo
echo "[OK] Relatorio criado:"
echo "$REPORT"