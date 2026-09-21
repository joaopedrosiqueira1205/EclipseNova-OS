#!/usr/bin/env bash
set -euo pipefail

VERSION="1.8.13"
SRC="/sources/iptables-${VERSION}"

echo "======================================"
echo " EclipseNova OS - iptables $VERSION"
echo "======================================"

if [ ! -d "$SRC" ]; then
    echo "[ERRO] Fonte nao encontrada: $SRC"
    exit 1
fi

cd "$SRC"

./configure --prefix=/usr \
            --disable-nftables \
            --enable-libipq

make -j1
make install

echo "[OK] iptables instalado."