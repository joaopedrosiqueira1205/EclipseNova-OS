#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/coreutils-9.11"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Coreutils 9.11"
echo "======================================"

patch -Np1 -i ../coreutils-9.11-i18n-1.patch

autoreconf -fv
automake -af

FORCE_UNSAFE_CONFIGURE=1 ./configure \
    --prefix=/usr

make -j1

echo "[INFO] Executando testes como root..."
make NON_ROOT_USERNAME=tester check-root

echo "[INFO] Executando testes como tester..."

groupadd -g 102 dummy -U tester
chown -R tester .

su tester -c "PATH=$PATH make -k RUN_EXPENSIVE_TESTS=yes check" \
    < /dev/null

groupdel dummy

make install

mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 \
      /usr/share/man/man8/chroot.8

sed -i 's/"1"/"8"/' \
    /usr/share/man/man8/chroot.8

echo
echo "[OK] Coreutils 9.11 instalado."