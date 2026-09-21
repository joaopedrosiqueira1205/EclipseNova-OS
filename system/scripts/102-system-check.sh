#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - System Check"
echo "======================================"

ERRORS=0

check_command() {
    if command -v "$1" >/dev/null 2>&1; then
        echo "[OK] $1"
    else
        echo "[ERRO] $1"
        ERRORS=$((ERRORS + 1))
    fi
}

check_command bash
check_command gcc
check_command make
check_command python3
check_command systemctl
check_command ip
check_command grub-install
check_command mount
check_command fsck

echo
echo "Kernel:"
ls -lh /boot/vmlinuz-* 2>/dev/null || true

echo
echo "Sistema:"
cat /etc/os-release 2>/dev/null || true

echo
echo "======================================"

if [ "$ERRORS" -eq 0 ]; then
    echo "[OK] Base do EclipseNova OS passou na verificacao."
else
    echo "[ERRO] Foram encontrados $ERRORS problema(s)."
    exit 1
fi