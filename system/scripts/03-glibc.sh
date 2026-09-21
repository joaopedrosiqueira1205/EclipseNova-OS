#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/glibc-2.44"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Glibc 2.44"
echo "======================================"

patch -Np1 -i ../glibc-fhs-1.patch
patch -Np1 -i ../glibc-2.44-upstream_fixes-1.patch

rm -rf build
mkdir -v build
cd build

../configure \
    --prefix=/usr \
    --disable-werror \
    --disable-nscd \
    libc_cv_slibdir=/usr/lib \
    --enable-stack-protector=strong \
    --enable-kernel=5.10

make -j1

echo
echo "[IMPORTANTE] Executando testes criticos da Glibc..."
make check

touch /etc/ld.so.conf

sed '/test-installation/s@$(PERL)@echo not running@' -i ../Makefile

make install

sed '/RTLDLIST=/s@/usr@@g' -i /usr/bin/ldd

echo
echo "[INFO] Instalando locales essenciais..."

localedef -i C -f UTF-8 C.UTF-8
localedef -i en_US -f UTF-8 en_US.UTF-8
localedef -i pt_BR -f UTF-8 pt_BR.UTF-8

cat > /etc/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files systemd
group: files systemd
shadow: files systemd

hosts: mymachines resolve [!UNAVAIL=return] files myhostname dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

cat > /etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf

/usr/local/lib
/opt/lib

# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF

mkdir -pv /etc/ld.so.conf.d

echo
echo "[OK] Glibc 2.44 instalada."