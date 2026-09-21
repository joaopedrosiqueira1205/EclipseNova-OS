#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum OS
# Preparacao da estrutura LFS
# Referencia: LFS 13.1-systemd
# ==========================================

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$PROJECT_ROOT/config/build-env.sh"

echo
echo "======================================"
echo " SolarNexum - Estrutura LFS"
echo "======================================"
echo

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Este script deve ser executado no Linux."
    exit 1
fi

: "${LFS:?ERRO: LFS nao definido}"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Esta etapa precisa ser executada como root."
    echo
    echo "No notebook use:"
    echo "sudo -E bash scripts/setup-lfs-layout.sh"
    exit 1
fi

echo "[1/4] Criando diretorios principais..."

mkdir -pv "$LFS"/{etc,var} "$LFS"/usr/{bin,lib,sbin}

echo
echo "[2/4] Criando links essenciais..."

for i in bin lib sbin; do
    if [ ! -e "$LFS/$i" ]; then
        ln -sv "usr/$i" "$LFS/$i"
    fi
done

echo
echo "[3/4] Preparando lib64 para x86_64..."

case "$(uname -m)" in
    x86_64)
        mkdir -pv "$LFS/lib64"
        ;;
esac

echo
echo "[4/4] Verificando estrutura..."

for DIR in \
    "$LFS/etc" \
    "$LFS/var" \
    "$LFS/usr/bin" \
    "$LFS/usr/lib" \
    "$LFS/usr/sbin"
do
    if [ ! -d "$DIR" ]; then
        echo "[ERRO] Diretorio ausente:"
        echo "$DIR"
        exit 1
    fi
done

echo
echo "======================================"
echo " [OK] Estrutura LFS preparada"
echo "======================================"