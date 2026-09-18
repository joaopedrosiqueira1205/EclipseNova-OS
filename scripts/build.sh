#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Build System 0.1
# ==========================================

echo "======================================"
echo "       SolarNexum Build System"
echo "======================================"
echo
echo "SolarNexum OS 0.1 - Genesis"
echo

# Detectar sistema
if [ "$(uname -s)" != "Linux" ]; then
    echo "ERRO: O Builder precisa ser executado no Linux."
    exit 1
fi

# Detectar arquitetura
ARCH="$(uname -m)"

if [ "$ARCH" != "x86_64" ]; then
    echo "ERRO: Arquitetura nao suportada: $ARCH"
    exit 1
fi

echo "[OK] Linux detectado"
echo "[OK] Arquitetura: $ARCH"

# Memoria
RAM_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
RAM_MB=$((RAM_KB / 1024))

echo "[INFO] RAM detectada: ${RAM_MB} MB"

if [ "$RAM_MB" -lt 3500 ]; then
    echo "[AVISO] Pouca memoria disponivel."
    echo "[AVISO] Swap sera importante durante a compilacao."
fi

# CPU
CPU_THREADS=$(nproc)

echo "[INFO] Threads de CPU: $CPU_THREADS"

echo
echo "======================================"
echo " Ambiente inicial aprovado"
echo "======================================"
echo
echo "Proxima etapa:"
echo "SolarNexum Toolchain"