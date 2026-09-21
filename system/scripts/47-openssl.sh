#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/openssl-4.0.1"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - OpenSSL 4.0.1"
echo "======================================"

./config \
    --prefix=/usr \
    --openssldir=/etc/ssl \
    --libdir=lib \
    shared \
    zlib-dynamic

make -j1

echo "[INFO] Executando testes..."
HARNESS_JOBS=1 make test

sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile

make MANSUFFIX=ssl install

mv -v /usr/share/doc/openssl /usr/share/doc/openssl-4.0.1

cp -vfr doc/* /usr/share/doc/openssl-4.0.1

echo
echo "[OK] OpenSSL 4.0.1 instalado."