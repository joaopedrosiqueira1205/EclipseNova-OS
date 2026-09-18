#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " SolarNexum Toolchain"
echo " Binutils 2.47 - Pass 1"
echo "======================================"

: "${LFS:?ERRO: variavel LFS nao definida}"
: "${LFS_TGT:?ERRO: variavel LFS_TGT nao definida}"

SOURCE="$LFS/sources/binutils-2.47"
BUILD="$SOURCE/build"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Binutils 2.47 nao encontrado."
    exit 1
fi

echo "[1/4] Preparando diretorio de build..."

rm -rf "$BUILD"
mkdir -v "$BUILD"
cd "$BUILD"

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

echo "[3/4] Compilando..."

make -j"${BUILD_JOBS:-1}"

echo "[4/4] Instalando..."

make install

echo
echo "======================================"
echo " Binutils Pass 1 concluido"
echo "======================================"