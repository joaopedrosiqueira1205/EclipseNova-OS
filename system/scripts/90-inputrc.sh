#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Inputrc"
echo "======================================"

cat > /etc/inputrc << "EOF"
# Begin /etc/inputrc

set horizontal-scroll-mode Off

set meta-flag On
set input-meta On
set convert-meta Off
set output-meta On

set bell-style none

"\eOd": backward-word
"\eOc": forward-word

"\e[1~": beginning-of-line
"\e[4~": end-of-line

"\e[4C": forward-word
"\e[4D": backward-word

"\e[1;5C": forward-word
"\e[1;5D": backward-word

"\e[5~": beginning-of-history
"\e[6~": end-of-history

"\e[3~": delete-char
"\e[2~": quoted-insert

# End /etc/inputrc
EOF

echo
echo "[OK] /etc/inputrc criado."