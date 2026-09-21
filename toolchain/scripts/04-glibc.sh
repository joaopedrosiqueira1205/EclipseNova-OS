#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Glibc 2.44
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
echo " Glibc 2.44"
echo "======================================"
echo

# Verificacoes de seguranca
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

SOURCE="$LFS/sources/glibc-2.44"
BUILD="$SOURCE/build"

PATCH_FHS="$LFS/sources/glibc-fhs-1.patch"
PATCH_FIXES="$LFS/sources/glibc-2.44-upstream_fixes-1.patch"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes da Glibc 2.44 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

for FILE in "$PATCH_FHS" "$PATCH_FIXES"; do
    if [ ! -f "$FILE" ]; then
        echo "[ERRO] Patch necessario nao encontrado:"
        echo "$FILE"
        exit 1
    fi
done

echo "[OK] Fontes e patches encontrados"
echo "[INFO] Target: $LFS_TGT"
echo "[INFO] Jobs: $BUILD_JOBS"
echo

# Links do carregador dinamico para x86_64
echo "[1/7] Preparando dynamic linker..."

mkdir -pv "$LFS/lib64"

ln -sfv ../lib/ld-linux-x86-64.so.2 \
    "$LFS/lib64/ld-linux-x86-64.so.2"

ln -sfv ../lib/ld-linux-x86-64.so.2 \
    "$LFS/lib64/ld-lsb-x86-64.so.3"

cd "$SOURCE"

# Aplicar patches
echo
echo "[2/7] Aplicando patches..."

patch -Np1 -i "$PATCH_FHS"
patch -Np1 -i "$PATCH_FIXES"

# Build separado
echo
echo "[3/7] Preparando diretorio de build..."

rm -rf "$BUILD"
mkdir -v "$BUILD"
cd "$BUILD"

echo "rootsbindir=/usr/sbin" > configparms

# Configuracao
echo
echo "[4/7] Configurando Glibc..."

../configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(../scripts/config.guess)" \
    --disable-nscd \
    libc_cv_slibdir=/usr/lib

# Compilacao
echo
echo "[5/7] Compilando Glibc..."

make -j"$BUILD_JOBS"

# Instalacao
echo
echo "[6/7] Instalando Glibc..."

make DESTDIR="$LFS" install

# Corrigir caminho do loader no ldd
sed '/RTLDLIST=/s@/usr@@g' -i "$LFS/usr/bin/ldd"

# Teste da cross-toolchain
echo
echo "[7/7] Testando toolchain..."

echo 'int main(){}' | \
    "$LFS_TGT-gcc" -x c - -v -Wl,--verbose \
    &> dummy.log

if ! "$LFS_TGT-readelf" -l a.out | grep -q ': /lib'; then
    echo
    echo "[ERRO] Dynamic linker incorreto."
    rm -f a.out dummy.log
    exit 1
fi

if ! grep -q "/lib.*/libc.so.6 " dummy.log; then
    echo
    echo "[ERRO] Glibc nao foi localizada corretamente."
    rm -f a.out dummy.log
    exit 1
fi

echo
echo "[OK] GCC conseguiu compilar e linkar com a nova Glibc."

rm -f a.out dummy.log

echo
echo "======================================"
echo " [OK] Glibc 2.44 concluida"
echo "======================================"