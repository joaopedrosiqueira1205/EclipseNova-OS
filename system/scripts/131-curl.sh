#!/usr/bin/env bash
set -euo pipefail

VERSION="8.21.0"
SRC="/sources/curl-${VERSION}"

echo "======================================"
echo " EclipseNova OS - cURL $VERSION"
echo "======================================"

if [ ! -d "$SRC" ]; then
    echo "[ERRO] Fonte nao encontrada: $SRC"
    exit 1
fi

if ! pkg-config --exists libpsl; then
    echo "[ERRO] libpsl precisa ser instalada primeiro."
    exit 1
fi

cd "$SRC"

./configure \
    --prefix=/usr \
    --disable-static \
    --with-openssl \
    --with-ca-path=/etc/ssl/certs

make -j1
make install

echo "[OK] cURL instalado."