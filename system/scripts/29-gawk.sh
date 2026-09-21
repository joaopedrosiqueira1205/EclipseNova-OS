#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/gawk-5.4.1"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Gawk 5.4.1"
echo "======================================"

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr

make -j1

chown -R tester .
su tester -c "PATH=$PATH make check"

rm -f /usr/bin/gawk-5.4.1
make install

ln -sv gawk.1 /usr/share/man/man1/awk.1

install -vDm644 doc/{awkforai.txt,*.{eps,pdf,jpg}} \
    -t /usr/share/doc/gawk-5.4.1

echo
echo "[OK] Gawk 5.4.1 instalado."