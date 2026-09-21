#!/usr/bin/env bash
set -euo pipefail

VERSION="3.15.0"
SRC="/sources/pciutils-${VERSION}"

echo "======================================"
echo " EclipseNova OS - PCI Utils $VERSION"
echo "======================================"

if [ ! -d "$SRC" ]; then
    echo "[ERRO] Fonte nao encontrada: $SRC"
    exit 1
fi

cd "$SRC"

make PREFIX=/usr \
     SHAREDIR=/usr/share/hwdata \
     SHARED=yes

make PREFIX=/usr \
     SHAREDIR=/usr/share/hwdata \
     SHARED=yes \
     install install-lib

chmod -v 755 /usr/lib/libpci.so

echo "[OK] PCI Utils instalado."