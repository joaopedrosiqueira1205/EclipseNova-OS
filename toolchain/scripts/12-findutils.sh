#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Findutils - Ferramenta Temporaria
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
echo " Findutils - Ferramenta Temporaria"
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

SOURCE="$LFS/sources/findutils-4.10.0"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Findutils nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Findutils..."

./configure \
    --prefix=/usr \
    --localstatedir=/var/lib/locate \
    --host="$LFS_TGT" \
    --build="$(build-aux/config.guess)"

echo
echo "[2/3] Compilando Findutils..."

make -j"$BUILD_JOBS"

echo
echo "[3/3] Instalando Findutils..."

make DESTDIR="$LFS" install

echo
echo "======================================"
echo " [OK] Findutils concluido"
echo "======================================"