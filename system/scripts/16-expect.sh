#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/expect5.45.4"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Expect 5.45.4"
echo "======================================"

echo "[INFO] Verificando PTY..."

python3 -c 'from pty import spawn; spawn(["echo", "ok"])'

patch -Np1 -i ../expect-5.45.4-gcc15-1.patch

./configure \
    --prefix=/usr \
    --with-tcl=/usr/lib \
    --enable-shared \
    --disable-rpath \
    --mandir=/usr/share/man \
    --with-tclinclude=/usr/include

make -j1
make test
make install

ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib

echo
echo "[OK] Expect 5.45.4 instalado."