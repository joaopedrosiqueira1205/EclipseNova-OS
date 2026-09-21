#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Chapter 7 - Logs iniciais
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
echo " SolarNexum - Logs Iniciais"
echo "======================================"
echo

echo "[1/3] Criando arquivos de log..."

touch /var/log/{btmp,lastlog,faillog,wtmp}

echo
echo "[2/3] Configurando grupos..."

chgrp -v utmp /var/log/lastlog
chgrp -v utmp /var/log/btmp

echo
echo "[3/3] Configurando permissoes..."

chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp

echo
echo "======================================"
echo " [OK] Logs iniciais preparados"
echo "======================================"