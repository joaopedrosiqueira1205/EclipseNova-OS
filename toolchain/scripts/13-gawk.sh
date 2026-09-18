#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Gawk 5.4.1 - Ferramenta Temporaria
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
echo " Gawk 5.4.1"
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

SOURCE="$LFS/sources/gawk-5.4.1"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Gawk 5.4.1 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/4] Removendo componentes desnecessarios..."

sed -i 's/extras//' Makefile.in

echo
echo "[2/4] Configurando Gawk..."

./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(build-aux/config.guess)"

echo
echo "[3/4] Compilando Gawk..."

make -j"$BUILD_JOBS"

echo
echo "[4/4] Instalando Gawk..."

make DESTDIR="$LFS" install

echo
echo "======================================"
echo " [OK] Gawk 5.4.1 concluido"
echo "======================================"