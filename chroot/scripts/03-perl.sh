#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Perl temporario
# LFS 13.1-systemd
# ==========================================

echo
echo "======================================"
echo " SolarNexum - Perl Temporario"
echo "======================================"
echo

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

SOURCE="/sources/perl-5.44.0"

if [ ! -d "$SOURCE" ]; then
    echo "[ERRO] Fontes do Perl 5.44.0 nao encontradas:"
    echo "$SOURCE"
    exit 1
fi

cd "$SOURCE"

echo "[1/3] Configurando Perl..."

sh Configure \
    -des \
    -D prefix=/usr \
    -D vendorprefix=/usr \
    -D useshrplib \
    -D privlib=/usr/lib/perl5/5.44/core_perl \
    -D archlib=/usr/lib/perl5/5.44/core_perl \
    -D sitelib=/usr/lib/perl5/5.44/site_perl \
    -D sitearch=/usr/lib/perl5/5.44/site_perl \
    -D vendorlib=/usr/lib/perl5/5.44/vendor_perl \
    -D vendorarch=/usr/lib/perl5/5.44/vendor_perl

echo
echo "[2/3] Compilando Perl..."

make -j1

echo
echo "[3/3] Instalando Perl..."

make install

echo
echo "======================================"
echo " [OK] Perl 5.44.0 temporario concluido"
echo "======================================"