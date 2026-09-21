#!/usr/bin/env bash
set -euo pipefail

REPORT="/root/eclipsenova-services.txt"

echo "======================================"
echo " EclipseNova OS - Enabled Services"
echo "======================================"

{
    echo "EclipseNova OS Enabled Services"
    echo "Generated: $(date)"
    echo

    systemctl list-unit-files \
        --type=service \
        --state=enabled

} > "$REPORT"

echo "[OK] Relatorio criado:"
echo "$REPORT"