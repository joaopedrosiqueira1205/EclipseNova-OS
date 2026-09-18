#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# GCC 16.2.0 - Pass 1
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
echo " GCC 16.2.0 - Pass 1"
echo "======================================"
echo

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Este script precisa ser executado no Linux."
    exit 1
fi

: "${LFS:?ERRO: LFS nao definido}"
: "${LFS_TGT:?ERRO: LFS_TGT nao definido}"
: "${BUILD_JOBS:?ERRO: BUILD_JOBS nao definido}"

SOURCE="$LFS/sources/gcc-16.2.0"
BUILD="$SOURCE/build"

MPFR_ARCHIVE="$LFS/sources/mpfr-4.2.2.tar.xz"
GMP_ARCHIVE="$LFS/sources/gmp-6.3.0.tar.xz"
MPC_ARCHIVE="$LFS/sources/mpc-1.4.1.tar.gz"

# Verificar arquivos necessarios

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do GCC 16.2.0 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

for FILE in "$MPFR_ARCHIVE" "$GMP_ARCHIVE" "$MPC_ARCHIVE"; do
    if [ ! -f "$FILE" ]; then
        echo "[ERRO] Arquivo necessario nao encontrado:"
        echo "$FILE"
        exit 1
    fi
done

echo "[OK] Fontes encontradas"
echo "[INFO] Target: $LFS_TGT"
echo "[INFO] Jobs: $BUILD_JOBS"
echo

cd "$SOURCE"

# Remover restos de uma tentativa anterior

rm -rf mpfr gmp mpc build

echo "[1/6] Preparando MPFR..."

tar -xf "$MPFR_ARCHIVE"
mv mpfr-4.2.2 mpfr

echo "[2/6] Preparando GMP..."

tar -xf "$GMP_ARCHIVE"
mv gmp-6.3.0 gmp

echo "[3/6] Preparando MPC..."

tar -xf "$MPC_ARCHIVE"
mv mpc-1.4.1 mpc

# Ajuste necessario em x86_64

case "$(uname -m)" in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
        ;;
esac

echo "[4/6] Configurando GCC..."

mkdir -v "$BUILD"
cd "$BUILD"

../configure \
    --target="$LFS_TGT" \
    --prefix="$LFS/tools" \
    --with-glibc-version=2.44 \
    --with-sysroot="$LFS" \
    --with-newlib \
    --without-headers \
    --enable-default-pie \
    --enable-default-ssp \
    --disable-fixincludes \
    --disable-nls \
    --disable-shared \
    --disable-multilib \
    --disable-threads \
    --disable-libatomic \
    --disable-libgomp \
    --disable-libquadmath \
    --disable-libssp \
    --disable-libvtv \
    --disable-libstdcxx \
    --enable-languages=c,c++

echo
echo "[5/6] Compilando GCC..."

make -j"$BUILD_JOBS"

echo
echo "[6/6] Instalando GCC..."

make install

# Criar limits.h completo necessario para as proximas etapas

cat ../gcc/limitx.h \
    ../gcc/glimits.h \
    ../gcc/limity.h \
    > "$("$LFS_TGT-gcc" -print-file-name=include)/limits.h"

echo
echo "======================================"
echo " [OK] GCC Pass 1 concluido"
echo "======================================"