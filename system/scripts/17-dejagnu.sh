#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/dejagnu-1.6.3"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - DejaGNU 1.6.3"
echo "======================================"

rm -rf build
mkdir -v build
cd build

../configure --prefix=/usr

makeinfo --html --no-split \
    -o doc/dejagnu.html ../doc/dejagnu.texi

makeinfo --plaintext \
    -o doc/dejagnu.txt ../doc/dejagnu.texi

make check
make install

install -v -dm755 /usr/share/doc/dejagnu-1.6.3

install -v -m644 \
    doc/dejagnu.{html,txt} \
    /usr/share/doc/dejagnu-1.6.3

echo
echo "[OK] DejaGNU 1.6.3 instalado."