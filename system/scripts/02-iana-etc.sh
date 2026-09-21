#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 8 - Iana-Etc 20260805
# LFS 13.1-systemd
# ==========================================

SOURCE="/sources/iana-etc-20260805"

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Este script deve ser executado no Linux."
    exit 1
fi

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute este script dentro do chroot como root."
    exit 1
fi

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fonte nao encontrada:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Iana-Etc 20260805"
echo "======================================"

echo "[1/1] Instalando arquivos de rede..."
cp -v services protocols /etc

echo
echo "[OK] Iana-Etc 20260805 instalado."