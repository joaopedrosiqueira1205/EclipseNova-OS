#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/shadow-4.20.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Shadow 4.20.2"
echo "======================================"

find man -name Makefile.in -exec sed -i 's/getspnam\.3 / /' {} \;
find man -name Makefile.in -exec sed -i 's/passwd\.5 / /' {} \;

sed -e 's:#ENCRYPT_METHOD SHA512:ENCRYPT_METHOD YESCRYPT:' \
    -e 's:/var/spool/mail:/var/mail:' \
    -e '/PATH=/{s@/sbin:@@;s@/bin:@@}' \
    -i etc/login.defs

touch /usr/bin/passwd

./configure \
    --sysconfdir=/etc \
    --disable-static \
    --with-{b,yes}crypt \
    --without-libbsd \
    --disable-logind \
    --with-group-name-max-length=32

make -j1

make exec_prefix=/usr install
make -C man install-man

pwconv
grpconv

mkdir -p /etc/default
useradd -D --gid 999

touch /etc/subuid
touch /etc/subgid

echo
echo "[OK] Shadow 4.20.2 instalado."
echo "[AVISO] A senha root sera configurada manualmente depois."