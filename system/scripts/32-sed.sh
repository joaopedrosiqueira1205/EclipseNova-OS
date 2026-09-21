#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/sed-4.10"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Sed 4.10"
echo "======================================"

./configure --prefix=/usr

make -j1
make html

chown -R tester .
su tester -c "PATH=$PATH make check"

make install

install -vDm644 doc/sed.html \
    -t /usr/share/doc/sed-4.10

echo
echo "[OK] Sed 4.10 instalado."