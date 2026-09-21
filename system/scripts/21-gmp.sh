#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/gmp-6.3.0"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - GMP 6.3.0"
echo "======================================"

sed -i '/long long t1;/,+1s/()/(...)/' configure

./configure \
    --prefix=/usr \
    --enable-cxx \
    --disable-static \
    --docdir=/usr/share/doc/gmp-6.3.0

make -j1
make html

echo
echo "[IMPORTANTE] Executando testes criticos do GMP..."

make check

echo
echo "[INFO] Quantidade de testes PASS:"
cat $(find -name '*.log') | grep -c '^PASS'

make install
make install-html

echo
echo "[OK] GMP 6.3.0 instalado."