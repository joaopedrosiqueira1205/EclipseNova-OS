#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Linux 7.1.8 API Headers
# ==========================================

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ENV_FILE="$PROJECT_ROOT/config/build-env.sh"

if [ ! -f "$ENV_FILE" ]; then
    echo "[ERRO] Configuracao de build nao encontrada:"
    echo "$ENV_FILE"
    exit 1
fi

source "$ENV_FILE"

echo
echo "======================================"
echo " SolarNexum Toolchain"
echo " Linux 7.1.8 API Headers"
echo "======================================"
echo

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Este script precisa ser executado no Linux."
    exit 1
fi

: "${LFS:?ERRO: LFS nao definido}"

SOURCE="$LFS/sources/linux-7.1.8"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Linux 7.1.8 nao encontradas:"
    echo "$SOURCE"
    echo
    echo "Execute primeiro o SolarNexum Source Manager."
    exit 1
fi

echo "[INFO] Source: $SOURCE"
echo "[INFO] Destino: $LFS/usr/include"
echo

cd "$SOURCE"

echo "[1/4] Limpando arquivos antigos..."

make mrproper

echo
echo "[2/4] Preparando Linux API Headers..."

make headers

echo
echo "[3/4] Removendo arquivos que nao sao headers..."

find usr/include -type f ! -name '*.h' -delete

echo
echo "[4/4] Instalando headers no SolarNexum..."

mkdir -pv "$LFS/usr"

cp -rv usr/include "$LFS/usr"

echo
echo "======================================"
echo " [OK] Linux API Headers instalados"
echo "======================================"