#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Toolchain
# Libstdc++ - GCC 16.2.0
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
echo " Libstdc++ - GCC 16.2.0"
echo "======================================"
echo

# Verificar sistema
if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Este script precisa ser executado no Linux."
    exit 1
fi

# Nao permitir execucao como root
if [ "$(id -u)" -eq 0 ]; then
    echo "[ERRO] Nao execute esta etapa como root."
    exit 1
fi

# Verificar variaveis
: "${LFS:?ERRO: LFS nao definido}"
: "${LFS_TGT:?ERRO: LFS_TGT nao definido}"
: "${BUILD_JOBS:?ERRO: BUILD_JOBS nao definido}"

SOURCE="$LFS/sources/gcc-16.2.0"
BUILD="$SOURCE/build-libstdcxx"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do GCC 16.2.0 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

echo "[OK] Fontes encontradas"
echo "[INFO] Source: $SOURCE"
echo "[INFO] Target: $LFS_TGT"
echo "[INFO] Jobs: $BUILD_JOBS"
echo

# Limpar build anterior
echo "[1/4] Preparando diretorio de build..."

rm -rf "$BUILD"
mkdir -v "$BUILD"

cd "$BUILD"

# Configurar Libstdc++
echo
echo "[2/4] Configurando Libstdc++..."

../libstdc++-v3/configure \
    --host="$LFS_TGT" \
    --build="$(../config.guess)" \
    --prefix=/usr \
    --disable-multilib \
    --disable-nls \
    --disable-libstdcxx-pch \
    --with-gxx-include-dir="/tools/$LFS_TGT/include/c++/16.2.0"

# Compilar
echo
echo "[3/4] Compilando Libstdc++..."

make -j"$BUILD_JOBS"

# Instalar
echo
echo "[4/4] Instalando Libstdc++..."

make DESTDIR="$LFS" install

# Remover arquivos libtool desnecessarios
rm -v "$LFS/usr/lib/lib"{stdc++{,exp,fs},supc++}.la 2>/dev/null || true

echo
echo "======================================"
echo " [OK] Libstdc++ concluida"
echo "======================================"