#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Bash 5.3 - Ferramenta Temporaria
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
echo " Bash 5.3 - Ferramenta Temporaria"
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

SOURCE="$LFS/sources/bash-5.3"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Bash 5.3 nao encontradas:"
    echo "$SOURCE"
    echo
    echo "Execute primeiro o SolarNexum Source Manager."
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Bash..."

./configure \
    --prefix=/usr \
    --build="$(sh support/config.guess)" \
    --host="$LFS_TGT" \
    --without-bash-malloc \
    --docdir=/usr/share/doc/bash-5.3

echo
echo "[2/3] Compilando Bash..."

make -j"$BUILD_JOBS"

echo
echo "[3/3] Instalando Bash..."

make DESTDIR="$LFS" install

# Muitos programas esperam encontrar /bin/sh.
ln -svf bash "$LFS/bin/sh"

echo
echo "======================================"
echo " [OK] Bash 5.3 concluido"
echo "======================================"