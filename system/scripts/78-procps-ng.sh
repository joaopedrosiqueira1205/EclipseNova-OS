#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/procps-ng-4.0.7"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Procps-ng 4.0.7"
echo "======================================"

./configure \
    --prefix=/usr \
    --docdir=/usr/share/doc/procps-ng-4.0.7 \
    --disable-static \
    --disable-kill \
    --enable-watch8bit \
    --with-systemd

make -j1

chown -R tester .
su tester -c "PATH=$PATH make check"

make install

echo
echo "[OK] Procps-ng 4.0.7 instalado."