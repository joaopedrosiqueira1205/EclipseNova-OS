#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Build System 0.1
# ==========================================

# Localizar automaticamente a raiz do projeto
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Carregar configuracao do ambiente
ENV_FILE="$PROJECT_ROOT/config/build-env.sh"

if [ ! -f "$ENV_FILE" ]; then
    echo "[ERRO] Arquivo de configuracao nao encontrado:"
    echo "$ENV_FILE"
    exit 1
fi

source "$ENV_FILE"

echo
echo "======================================"
echo "       SolarNexum Build System"
echo "======================================"
echo
echo "SolarNexum OS 0.1 - Genesis"
echo

# Verificar sistema operacional
if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] O Builder precisa ser executado no Linux."
    exit 1
fi

echo "[OK] Linux detectado"

# Verificar arquitetura
ARCH="$(uname -m)"

if [ "$ARCH" != "x86_64" ]; then
    echo "[ERRO] Arquitetura nao suportada: $ARCH"
    exit 1
fi

echo "[OK] Arquitetura: $ARCH"

# Detectar memoria RAM
RAM_KB="$(awk '/MemTotal/ {print $2}' /proc/meminfo)"
RAM_MB=$((RAM_KB / 1024))

echo "[INFO] RAM detectada: ${RAM_MB} MB"

if [ "$RAM_MB" -lt 3500 ]; then
    echo "[AVISO] Pouca memoria RAM detectada."
    echo "[AVISO] Swap pode ser necessaria durante a compilacao."
fi

# Detectar CPU
CPU_THREADS="$(nproc)"

echo "[INFO] Threads de CPU: $CPU_THREADS"
echo "[INFO] Jobs de compilacao: $BUILD_JOBS"

# Mostrar configuracao da toolchain
echo
echo "Configuracao:"
echo "LFS:       $LFS"
echo "Target:    $LFS_TGT"
echo "Sources:   $SOLARNEXUM_SOURCES"
echo "Tools:     $SOLARNEXUM_TOOLS"

echo
echo "======================================"
echo " Ambiente inicial aprovado"
echo "======================================"
echo
echo "Proxima etapa:"
echo "SolarNexum Toolchain"