#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Diffutils 3.12 - Ferramenta Temporaria
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
echo " Diffutils 3.12"
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

SOURCE="$LFS/sources/diffutils-3.12"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Diffutils 3.12 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Diffutils..."

./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    gl_cv_func_strcasecmp_works=yes \
    --build="$(./build-aux/config.guess)"

echo
echo "[2/3] Compilando Diffutils..."

make -j"$BUILD_JOBS"

echo
echo "[3/3] Instalando Diffutils..."

make DESTDIR="$LFS" install

echo
echo "======================================"
echo " [OK] Diffutils 3.12 concluido"
echo "======================================"