#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Virtual Kernel File Systems
# LFS 13.1-systemd
# ==========================================

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$PROJECT_ROOT/config/build-env.sh"

echo
echo "======================================"
echo " SolarNexum - Virtual File Systems"
echo "======================================"
echo

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Execute este script somente no Linux."
    exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Esta etapa precisa ser executada como root."
    echo "Use:"
    echo "sudo -E bash scripts/mount-lfs-filesystems.sh"
    exit 1
fi

: "${LFS:?ERRO: LFS nao definido}"

echo "[1/6] Criando pontos de montagem..."

mkdir -pv "$LFS"/{dev,proc,sys,run}

echo
echo "[2/6] Preparando /dev..."

if ! mountpoint -q "$LFS/dev"; then
    mount -v --bind /dev "$LFS/dev"
else
    echo "[OK] $LFS/dev ja esta montado."
fi

echo
echo "[3/6] Preparando /dev/pts..."

if ! mountpoint -q "$LFS/dev/pts"; then
    mount -vt devpts devpts \
        -o gid=5,mode=0620 \
        "$LFS/dev/pts"
else
    echo "[OK] $LFS/dev/pts ja esta montado."
fi

echo
echo "[4/6] Preparando /proc..."

if ! mountpoint -q "$LFS/proc"; then
    mount -vt proc proc "$LFS/proc"
else
    echo "[OK] $LFS/proc ja esta montado."
fi

echo
echo "[5/6] Preparando /sys..."

if ! mountpoint -q "$LFS/sys"; then
    mount -vt sysfs sysfs "$LFS/sys"
else
    echo "[OK] $LFS/sys ja esta montado."
fi

echo
echo "[6/6] Preparando /run..."

if ! mountpoint -q "$LFS/run"; then
    mount -vt tmpfs tmpfs "$LFS/run"
else
    echo "[OK] $LFS/run ja esta montado."
fi

echo
echo "======================================"
echo " [OK] Sistemas de arquivos preparados"
echo "======================================"
echo

findmnt | grep "$LFS" || true