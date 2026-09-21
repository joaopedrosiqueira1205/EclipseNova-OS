#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Boot Check"
echo "======================================"

ERRORS=0

check_file() {
    if [ -e "$1" ]; then
        echo "[OK] $1"
    else
        echo "[ERRO] $1 nao encontrado."
        ERRORS=$((ERRORS + 1))
    fi
}

check_file /etc/fstab
check_file /etc/hostname
check_file /etc/os-release
check_file /boot/vmlinuz-7.1.8-solarnexum

if [ -d /sys/firmware/efi ]; then
    echo "[OK] Ambiente UEFI detectado."
else
    echo "[AVISO] Ambiente UEFI nao detectado."
fi

echo

if [ "$ERRORS" -ne 0 ]; then
    echo "[ERRO] $ERRORS verificacao(oes) falharam."
    exit 1
fi

echo "[OK] Verificacoes basicas concluidas."