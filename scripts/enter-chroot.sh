#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Entrada no Chroot
# LFS 13.1-systemd
# ==========================================

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$PROJECT_ROOT/config/build-env.sh"

echo
echo "======================================"
echo " SolarNexum - Entrada no Chroot"
echo "======================================"
echo

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Execute este script somente no Linux."
    exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Esta etapa precisa ser executada como root."
    echo
    echo "Use:"
    echo "sudo -E bash scripts/enter-chroot.sh"
    exit 1
fi

: "${LFS:?ERRO: LFS nao definido}"

# Verificar se a estrutura basica existe
if [ ! -d "$LFS/usr" ] || [ ! -d "$LFS/tools" ]; then
    echo "[ERRO] Estrutura do SolarNexum incompleta em:"
    echo "$LFS"
    exit 1
fi

# Verificar os sistemas de arquivos virtuais
for DIR in dev proc sys run; do
    if ! mountpoint -q "$LFS/$DIR"; then
        echo "[ERRO] $LFS/$DIR nao esta montado."
        echo
        echo "Execute primeiro:"
        echo "sudo -E bash scripts/mount-lfs-filesystems.sh"
        exit 1
    fi
done

echo "[OK] Estrutura verificada."
echo "[OK] Sistemas de arquivos virtuais montados."
echo
echo "[INFO] Entrando no SolarNexum..."
echo

chroot "$LFS" /usr/bin/env -i \
    HOME=/root \
    TERM="${TERM:-xterm}" \
    PS1='(SolarNexum chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin \
    MAKEFLAGS="-j1" \
    TESTSUITEFLAGS="-j1" \
    /bin/bash --login