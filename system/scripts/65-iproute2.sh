#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/iproute2-7.1.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - IPRoute2 7.1.0"
echo "======================================"

# arpd depende do Berkeley DB, que nao faz parte
# da base LFS.
sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8

make -j1 NETNS_RUN_DIR=/run/netns

make SBINDIR=/usr/sbin install

install -vDm644 COPYING README* \
    -t /usr/share/doc/iproute2-7.1.0

echo
echo "[OK] IPRoute2 7.1.0 instalado."