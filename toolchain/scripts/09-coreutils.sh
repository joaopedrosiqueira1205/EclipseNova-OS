#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Coreutils 9.11 - Ferramenta Temporaria
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
echo " Coreutils 9.11"
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

SOURCE="$LFS/sources/coreutils-9.11"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Coreutils 9.11 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/4] Configurando Coreutils..."

./configure \
    --prefix=/usr \
    --host="$LFS_TGT" \
    --build="$(build-aux/config.guess)" \
    --enable-install-program=hostname

echo
echo "[2/4] Compilando Coreutils..."

make -j"$BUILD_JOBS"

echo
echo "[3/4] Instalando Coreutils..."

make DESTDIR="$LFS" install

echo
echo "[4/4] Ajustando chroot..."

mv -v "$LFS/usr/bin/chroot" "$LFS/usr/sbin"

mkdir -pv "$LFS/usr/share/man/man8"

mv -v \
    "$LFS/usr/share/man/man1/chroot.1" \
    "$LFS/usr/share/man/man8/chroot.8"

sed -i 's/"1"/"8"/' \
    "$LFS/usr/share/man/man8/chroot.8"

echo
echo "======================================"
echo " [OK] Coreutils 9.11 concluido"
echo "======================================"