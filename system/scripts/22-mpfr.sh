#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/mpfr-4.2.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - MPFR 4.2.2"
echo "======================================"

./configure \
    --prefix=/usr \
    --disable-static \
    --enable-thread-safe \
    --docdir=/usr/share/doc/mpfr-4.2.2

make -j1
make html

echo
echo "[IMPORTANTE] Executando testes criticos do MPFR..."

make check

make install
make install-html

echo
echo "[OK] MPFR 4.2.2 instalado."