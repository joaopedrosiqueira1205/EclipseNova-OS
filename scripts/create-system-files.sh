#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Arquivos essenciais
# LFS 13.1-systemd
#
# Executar DENTRO do chroot como root.
# ==========================================

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute como root dentro do chroot."
    exit 1
fi

echo
echo "======================================"
echo " SolarNexum - Arquivos do Sistema"
echo "======================================"
echo

echo "[1/5] Criando /etc/passwd..."

cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/usr/bin/false
daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
nobody:x:65534:65534:Unprivileged User:/dev/null:/usr/bin/false
EOF

echo "[2/5] Criando /etc/group..."

cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
users:x:999:
nogroup:x:65534:
EOF

echo "[3/5] Atualizando ambiente do root..."

exec /usr/bin/bash --login