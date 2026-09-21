#!/usr/bin/env bash
set -euo pipefail

VERSION="019"
SRC="/sources/usbutils-${VERSION}"

echo "======================================"
echo " EclipseNova OS - USB Utils $VERSION"
echo "======================================"

if [ ! -d "$SRC" ]; then
    echo "[ERRO] Fonte nao encontrada: $SRC"
    exit 1
fi

cd "$SRC"

./configure --prefix=/usr \
            --datadir=/usr/share/hwdata

make -j1
make install

echo "[OK] USB Utils instalado."