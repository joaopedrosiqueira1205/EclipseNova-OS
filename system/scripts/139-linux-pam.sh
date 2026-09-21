#!/usr/bin/env bash
set -euo pipefail

VERSION="1.7.2"
SRC="/sources/Linux-PAM-${VERSION}"

echo "======================================"
echo " EclipseNova OS - Linux PAM $VERSION"
echo "======================================"

if [ ! -d "$SRC" ]; then
    echo "[ERRO] Fonte nao encontrada: $SRC"
    exit 1
fi

cd "$SRC"
rm -rf build
mkdir build
cd build

meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -D docs=disabled

ninja -j1
ninja install

echo "[OK] Linux-PAM instalado."