#!/usr/bin/env bash
set -euo pipefail

VERSION="0.23.3"
SRC="/sources/libpsl-${VERSION}"

echo "======================================"
echo " EclipseNova OS - libpsl $VERSION"
echo "======================================"

if [ ! -d "$SRC" ]; then
    echo "[ERRO] Fonte nao encontrada: $SRC"
    exit 1
fi

cd "$SRC"

rm -rf build
mkdir build
cd build

meson setup \
    --prefix=/usr \
    --buildtype=release

ninja -j1
ninja install

echo "[OK] libpsl instalado."