#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " EclipseNova OS - EFI Preparation"
echo "======================================"

mkdir -pv /boot/efi
mkdir -pv /boot/grub

echo
echo "[OK] Diretorios de boot preparados."
echo
echo "[IMPORTANTE]"
echo "A particao EFI ainda precisa ser identificada"
echo "e montada em /boot/efi antes do grub-install."