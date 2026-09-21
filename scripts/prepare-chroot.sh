#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Preparacao interna do Chroot
# LFS 13.1-systemd
#
# Este script deve ser executado DENTRO
# do ambiente chroot.
# ==========================================

echo
echo "======================================"
echo " SolarNexum - Preparando Chroot"
echo "======================================"
echo

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute como root dentro do chroot."
    exit 1
fi

echo "[1/5] Criando diretorios principais..."

mkdir -pv /{boot,home,mnt,opt,srv}

mkdir -pv /etc/{opt,sysconfig}
mkdir -pv /lib/firmware
mkdir -pv /media/{floppy,cdrom}

mkdir -pv /usr/{,local/}{include,src}
mkdir -pv /usr/lib/locale
mkdir -pv /usr/local/{bin,lib,sbin}

mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}

mkdir -pv /var/{cache,local,log,mail,opt,spool}
mkdir -pv /var/lib/{color,misc,locate}

echo
echo "[2/5] Criando links de /var..."

ln -sfv /run /var/run
ln -sfv /run/lock /var/lock

echo
echo "[3/5] Configurando permissoes..."

install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp

echo
echo "[4/5] Criando /etc/mtab..."

ln -sfv /proc/self/mounts /etc/mtab

echo
echo "[5/5] Criando /etc/hosts..."

cat > /etc/hosts << EOF
127.0.0.1  localhost $(hostname)
::1        localhost
EOF

echo
echo "======================================"
echo " [OK] Estrutura interna preparada"
echo "======================================"