#!/usr/bin/env bash
set -euo pipefail

VERSION="1.9"
SRC="/sources/libndp-${VERSION}"

echo "======================================"
echo " EclipseNova OS - libndp $VERSION"
echo "======================================"

if [ ! -d "$SRC" ]; then
    echo "[ERRO] Fonte nao encontrada: $SRC"
    exit 1
fi

cd "$SRC"

./configure --prefix=/usr \
            --sysconfdir=/etc \
            --disable-static

make -j1
make install

echo "[OK] libndp instalado."