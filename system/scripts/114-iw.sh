#!/usr/bin/env bash
set -euo pipefail

VERSION="6.17"
SRC="/sources/iw-${VERSION}"

echo "======================================"
echo " EclipseNova OS - iw $VERSION"
echo "======================================"

if ! pkg-config --exists libnl-3.0 libnl-genl-3.0; then
    echo "[ERRO] libnl precisa ser instalado primeiro."
    exit 1
fi

if [ ! -d "$SRC" ]; then
    echo "[ERRO] Fonte nao encontrada: $SRC"
    exit 1
fi

cd "$SRC"

make -j1
make install

echo "[OK] iw instalado."