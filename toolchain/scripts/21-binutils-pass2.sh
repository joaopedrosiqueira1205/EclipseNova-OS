#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Binutils 2.47 - Pass 2
# ==========================================

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
source "$PROJECT_ROOT/config/build-env.sh"

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Execute somente no Linux."
    exit 1
fi

if [ "$(id -u)" -eq 0 ]; then
    echo "[ERRO] Nao execute como root."
    exit 1
fi

: "${LFS:?}"
: "${LFS_TGT:?}"
: "${BUILD_JOBS:?}"

SOURCE="$LFS/sources/binutils-2.47"
BUILD="$SOURCE/build"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Binutils 2.47 nao encontrado."
    exit 1
fi

cd "$SOURCE"

echo "[1/5] Aplicando ajuste do libtool..."

sed '6031s/$add_dir//' -i ltmain.sh

echo "[2/5] Preparando build..."

rm -rf "$BUILD"
mkdir -v "$BUILD"
cd "$BUILD"

echo "[3/5] Configurando..."

../configure \
    --prefix=/usr \
    --build="$(../config.guess)" \
    --host="$LFS_TGT" \
    --disable-nls \
    --enable-shared \
    --enable-gprofng=no \
    --disable-werror \
    --enable-64-bit-bfd \
    --enable-new-dtags \
    --enable-default-hash-style=gnu

echo "[4/5] Compilando..."

make -j"$BUILD_JOBS"

echo "[5/5] Instalando..."

make DESTDIR="$LFS" install

rm -v \
    "$LFS/usr/lib/lib"{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}

echo
echo "======================================"
echo " [OK] Binutils Pass 2 concluido"
echo "======================================"