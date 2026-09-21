#!/usr/bin/env bash
set -euo pipefail

VERSION="1.58.1"
SRC="/sources/NetworkManager-${VERSION}"

echo "======================================"
echo " EclipseNova OS - NetworkManager $VERSION"
echo "======================================"

if [ ! -d "$SRC" ]; then
    echo "[ERRO] Fonte nao encontrada: $SRC"
    exit 1
fi

cd "$SRC"

grep -rl '^#!.*python$' . 2>/dev/null |
    xargs -r sed -i '1s/python/&3/'

rm -rf build
mkdir build
cd build

meson setup .. \
    --prefix=/usr \
    --buildtype=release \
    -D libaudit=no \
    -D nmtui=true \
    -D ovs=false \
    -D ppp=false \
    -D nbft=false \
    -D selinux=false \
    -D qt=false \
    -D session_tracking=systemd \
    -D nm_cloud_setup=false \
    -D clat=false \
    -D modem_manager=false

ninja -j1
ninja install

echo
echo "[OK] NetworkManager instalado."
echo "[INFO] Execute depois os scripts 134 e 136."