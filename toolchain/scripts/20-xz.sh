#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Xz 5.8.3 - Ferramenta Temporaria
# ==========================================

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
ENV_FILE="$PROJECT_ROOT/config/build-env.sh"

if [ ! -f "$ENV_FILE" ]; then
    echo "[ERRO] Configuracao de build nao encontrada:"
    echo "$ENV_FILE"
    exit 1
fi

source "$ENV_FILE"

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

SOURCE="$LFS/sources/xz-5.8.3"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Xz 5.8.3 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/4] Configurando Xz..."

./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(build-aux/config.guess)" \
    --disable-static \
    --docdir=/usr/share/doc/xz-5.8.3

echo "[2/4] Compilando Xz..."

make -j"$BUILD_JOBS"

echo "[3/4] Instalando Xz..."

make DESTDIR="$LFS" install

echo "[4/4] Removendo arquivo libtool..."

rm -v "$LFS/usr/lib/liblzma.la"

echo
echo "======================================"
echo " [OK] Xz 5.8.3 concluido"
echo "======================================"