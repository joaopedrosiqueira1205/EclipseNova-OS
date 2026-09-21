#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS - Source Preparer
# LFS 13.1-systemd
#
# Uso:
#   bash scripts/prepare-sources.sh <arquivo> <diretorio>
#
# Exemplo:
#   bash scripts/prepare-sources.sh \
#       gcc-16.2.0.tar.xz gcc-16.2.0
# ==========================================

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$PROJECT_ROOT/config/build-env.sh"

SOURCE_DIR="$LFS/sources"

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Execute este script somente no Linux."
    exit 1
fi

if [ "$#" -ne 2 ]; then
    echo "Uso:"
    echo "  $0 <arquivo.tar.*> <diretorio>"
    exit 1
fi

ARCHIVE="$1"
DIRECTORY="$2"

ARCHIVE_PATH="$SOURCE_DIR/$ARCHIVE"
DIRECTORY_PATH="$SOURCE_DIR/$DIRECTORY"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "[ERRO] Diretorio de fontes nao encontrado:"
    echo "$SOURCE_DIR"
    exit 1
fi

if [ ! -f "$ARCHIVE_PATH" ]; then
    echo "[ERRO] Arquivo de fonte nao encontrado:"
    echo "$ARCHIVE_PATH"
    exit 1
fi

cd "$SOURCE_DIR"

echo
echo "======================================"
echo " SolarNexum Source Preparer"
echo "======================================"
echo
echo "[INFO] Arquivo: $ARCHIVE"
echo "[INFO] Diretorio: $DIRECTORY"
echo

# Garantir uma arvore de fontes limpa.
if [ -d "$DIRECTORY_PATH" ]; then
    echo "[INFO] Removendo fonte preparada anteriormente..."
    rm -rf "$DIRECTORY_PATH"
fi

echo "[INFO] Extraindo fonte limpa..."

tar -xf "$ARCHIVE"

if [ ! -d "$DIRECTORY_PATH" ]; then
    echo
    echo "[ERRO] A extracao nao criou o diretorio esperado:"
    echo "$DIRECTORY_PATH"
    exit 1
fi

echo
echo "======================================"
echo " [OK] Fonte preparada"
echo " $DIRECTORY_PATH"
echo "======================================"