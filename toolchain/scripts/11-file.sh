#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# File 5.48 - Ferramenta Temporaria
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
echo " File 5.48"
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

SOURCE="$LFS/sources/file-5.48"
BUILD="$SOURCE/build"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do File 5.48 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/4] Preparando File para o host..."

rm -rf "$BUILD"
mkdir -v "$BUILD"

pushd "$BUILD"

../configure \
    --disable-bzlib \
    --disable-libseccomp \
    --disable-xzlib \
    --disable-zlib

make -j"$BUILD_JOBS"

popd

echo
echo "[2/4] Configurando File para o SolarNexum..."

./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(./config.guess)"

echo
echo "[3/4] Compilando File..."

make FILE_COMPILE="$BUILD/src/file" \
    -j"$BUILD_JOBS"

echo
echo "[4/4] Instalando File..."

make DESTDIR="$LFS" install

rm -v "$LFS/usr/lib/libmagic.la" 2>/dev/null || true

echo
echo "======================================"
echo " [OK] File 5.48 concluido"
echo "======================================"