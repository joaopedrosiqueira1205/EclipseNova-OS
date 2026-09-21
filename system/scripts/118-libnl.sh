#!/usr/bin/env bash
set -euo pipefail

VERSION="3.12.0"
SRC="/sources/libnl-${VERSION}"

echo "======================================"
echo " EclipseNova OS - libnl $VERSION"
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

echo "[OK] libnl instalado."