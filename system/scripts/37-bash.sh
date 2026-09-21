#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/bash-5.3"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Bash 5.3"
echo "======================================"

./configure \
    --prefix=/usr \
    --without-bash-malloc \
    --with-installed-readline \
    --docdir=/usr/share/doc/bash-5.3

make -j1

echo "[INFO] Preparando testes..."

chown -R tester .

LC_ALL=C.UTF-8 su -s /usr/bin/expect tester << "EOF"
set timeout -1
spawn make tests
expect eof
lassign [wait] _ _ _ value
exit $value
EOF

make install

echo
echo "[OK] Bash 5.3 instalado."
echo "[INFO] Ao executar manualmente, reinicie o shell com:"
echo "exec /usr/bin/bash --login"