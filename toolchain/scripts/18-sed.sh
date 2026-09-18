#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Sed 4.10 - Ferramenta Temporaria
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
echo " Sed 4.10"
echo "======================================"
echo

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Este script precisa ser executado no Linux."
    exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
    echo "[ERRO] Nao execute esta etapa como root."
    exit 1
fi

: "${LFS:?ERRO: LFS nao definido}"
: "${LFS_TGT:?ERRO: LFS_TGT nao definido}"
: "${BUILD_JOBS:?ERRO: BUILD_JOBS nao definido}"

SOURCE="$LFS/sources/sed-4.10"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Sed 4.10 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Sed..."

./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(./build-aux/config.guess)"

echo
echo "[2/3] Compilando Sed..."

make -j"$BUILD_JOBS"

echo
echo "[3/3] Instalando Sed..."

make DESTDIR="$LFS" install

echo
echo "======================================"
echo " [OK] Sed 4.10 concluido"
echo "======================================"