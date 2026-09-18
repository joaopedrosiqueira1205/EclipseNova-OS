#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Ncurses 6.6 - Ferramenta Temporaria
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
echo " Ncurses 6.6"
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

SOURCE="$LFS/sources/ncurses-6.6"
BUILD="$SOURCE/build"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Ncurses 6.6 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/6] Limpando build anterior..."

rm -rf "$BUILD"
mkdir -v "$BUILD"

echo
echo "[2/6] Construindo tic para o host..."

cd "$BUILD"

../configure \
    --prefix="$LFS/tools" \
    AWK=gawk

make -C include
make -C progs tic

mkdir -pv "$LFS/tools/bin"
install progs/tic "$LFS/tools/bin"

cd "$SOURCE"

echo
echo "[3/6] Configurando Ncurses..."

./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(./config.guess)" \
    --mandir=/usr/share/man \
    --with-manpage-format=normal \
    --with-shared \
    --without-normal \
    --with-cxx-shared \
    --without-debug \
    --without-ada \
    --disable-stripping \
    AWK=gawk

echo
echo "[4/6] Compilando Ncurses..."

make -j"$BUILD_JOBS"

echo
echo "[5/6] Instalando Ncurses..."

make DESTDIR="$LFS" install

echo
echo "[6/6] Criando compatibilidade libncurses..."

ln -sfv libncursesw.so "$LFS/usr/lib/libncurses.so"

sed -e 's/^#if.*XOPEN.*$/#if 1/' \
    -i "$LFS/usr/include/curses.h"

echo
echo "======================================"
echo " [OK] Ncurses 6.6 concluido"
echo "======================================"