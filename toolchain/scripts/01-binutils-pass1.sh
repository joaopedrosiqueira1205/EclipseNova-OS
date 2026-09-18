#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Binutils - Pass 1
# ==========================================

# Encontrar a raiz do projeto
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Carregar ambiente do SolarNexum
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
echo " Binutils - Pass 1"
echo "======================================"
echo

# Verificar se estamos no Linux
if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Este script precisa ser executado no Linux."
    exit 1
fi

# Verificar variaveis essenciais
: "${LFS:?ERRO: LFS nao definido}"
: "${LFS_TGT:?ERRO: LFS_TGT nao definido}"
: "${BUILD_JOBS:?ERRO: BUILD_JOBS nao definido}"

SOURCE="$LFS/sources/binutils-2.47"
BUILD="$SOURCE/build"

# Verificar fontes
if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Binutils nao encontradas:"
    echo "$SOURCE"
    echo
    echo "Execute primeiro o SolarNexum Source Manager."
    exit 1
fi

echo "[INFO] Source: $SOURCE"
echo "[INFO] Target: $LFS_TGT"
echo "[INFO] Jobs: $BUILD_JOBS"
echo

# Criar diretorio de compilacao limpo
echo "[1/4] Preparando build..."

rm -rf "$BUILD"
mkdir -v "$BUILD"

cd "$BUILD"

# Configurar Binutils
echo
echo "[2/4] Configurando Binutils..."

../configure \
    --prefix="$LFS/tools" \
    --with-sysroot="$LFS" \
    --target="$LFS_TGT" \
    --disable-nls \
    --enable-gprofng=no \
    --disable-werror \
    --enable-new-dtags \
    --enable-default-hash-style=gnu

# Compilar
echo
echo "[3/4] Compilando..."

make -j"$BUILD_JOBS"

# Instalar na toolchain temporaria
echo
echo "[4/4] Instalando..."

make install

echo
echo "======================================"
echo " [OK] Binutils Pass 1 concluido"
echo "======================================"