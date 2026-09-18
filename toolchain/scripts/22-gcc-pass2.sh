#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# GCC 16.2.0 - Pass 2
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

SOURCE="$LFS/sources/gcc-16.2.0"
BUILD="$SOURCE/build"

MPFR="$LFS/sources/mpfr-4.2.2.tar.xz"
GMP="$LFS/sources/gmp-6.3.0.tar.xz"
MPC="$LFS/sources/mpc-1.4.1.tar.xz"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] GCC 16.2.0 nao encontrado."
    exit 1
fi

for FILE in "$MPFR" "$GMP" "$MPC"; do
    if [ ! -f "$FILE" ]; then
        echo "[ERRO] Arquivo nao encontrado: $FILE"
        exit 1
    fi
done

cd "$SOURCE"

echo "[1/6] Preparando GMP, MPFR e MPC..."

rm -rf mpfr gmp mpc "$BUILD"

tar -xf "$MPFR"
mv mpfr-4.2.2 mpfr

tar -xf "$GMP"
mv gmp-6.3.0 gmp

tar -xf "$MPC"
mv mpc-1.4.1 mpc

echo "[2/6] Ajustando bibliotecas x86_64..."

case "$(uname -m)" in
    x86_64)
        sed -e '/m64=/s/lib64/lib/' \
            -i.orig gcc/config/i386/t-linux64
        ;;
esac

echo "[3/6] Criando diretorio de build..."

mkdir -v "$BUILD"
cd "$BUILD"

# Evitar flags externas interferindo na compilacao.
unset CFLAGS
unset CXXFLAGS

echo "[4/6] Configurando GCC..."

../configure \
    --build="$(../config.guess)" \
    --host="$LFS_TGT" \
    --target="$LFS_TGT" \
    --prefix=/usr \
    --with-build-sysroot="$LFS" \
    --enable-default-pie \
    --enable-default-ssp \
    --disable-fixincludes \
    --disable-nls \
    --disable-multilib \
    --disable-libatomic \
    --disable-libgomp \
    --disable-libquadmath \
    --disable-libsanitizer \
    --disable-libssp \
    --disable-libvtv \
    --enable-languages=c,c++ \
    CXX_FOR_TARGET="$LFS_TGT-gcc -nostdinc++" \
    LDFLAGS_FOR_TARGET="-L$PWD/$LFS_TGT/libgcc" \
    target_configargs=gcc_cv_target_thread_file=posix

echo "[5/6] Compilando GCC..."

make -j"$BUILD_JOBS"

echo "[6/6] Instalando GCC..."

make DESTDIR="$LFS" install

ln -svf gcc "$LFS/usr/bin/cc"

echo
echo "======================================"
echo " [OK] GCC Pass 2 concluido"
echo "======================================"