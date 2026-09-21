#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/Python-3.14.7"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Python 3.14.7"
echo "======================================"

patch -Np1 -i ../Python-3.14.7-openssl_4-1.patch

./configure \
    --prefix=/usr \
    --enable-shared \
    --with-system-expat \
    --enable-optimizations \
    --without-static-libpython

make -j1
make install

cat > /etc/pip.conf << "EOF"
[global]
root-user-action = ignore
disable-pip-version-check = true
EOF

if [ -f ../python-3.14.7-docs-html.tar.bz2 ]; then
    install -v -dm755 /usr/share/doc/python-3.14.7/html

    tar --strip-components=1 \
        --no-same-owner \
        --no-same-permissions \
        -C /usr/share/doc/python-3.14.7/html \
        -xvf ../python-3.14.7-docs-html.tar.bz2
fi

echo
echo "[INFO] Python instalado:"
python3 --version

echo
echo "[OK] Python 3.14.7 instalado."