#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo "   SolarNexum OS - Host Check 0.1"
echo "======================================"
echo

ERRORS=0
WARNINGS=0

# Sistema operacional
if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Este ambiente nao e Linux."
    ERRORS=$((ERRORS + 1))
else
    echo "[OK] Linux"
fi

# Arquitetura
ARCH="$(uname -m)"

if [ "$ARCH" = "x86_64" ]; then
    echo "[OK] Arquitetura: $ARCH"
else
    echo "[ERRO] Arquitetura: $ARCH"
    ERRORS=$((ERRORS + 1))
fi

echo
echo "Verificando ferramentas..."

TOOLS="bash gcc g++ make ld as awk sed grep tar xz python3 perl"

for TOOL in $TOOLS; do
    if command -v "$TOOL" >/dev/null 2>&1; then
        echo "[OK] $TOOL"
    else
        echo "[ERRO] $TOOL nao encontrado"
        ERRORS=$((ERRORS + 1))
    fi
done

echo
echo "Verificando hardware..."

# RAM
RAM_KB=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
RAM_MB=$((RAM_KB / 1024))

echo "[INFO] RAM: ${RAM_MB} MB"

if [ "$RAM_MB" -lt 3500 ]; then
    echo "[AVISO] Menos de aproximadamente 4 GB de RAM."
    WARNINGS=$((WARNINGS + 1))
fi

# Swap
SWAP_KB=$(awk '/SwapTotal/ {print $2}' /proc/meminfo)
SWAP_MB=$((SWAP_KB / 1024))

echo "[INFO] Swap: ${SWAP_MB} MB"

if [ "$SWAP_MB" -lt 4096 ]; then
    echo "[AVISO] Recomendamos pelo menos 4 GB de swap para este build."
    WARNINGS=$((WARNINGS + 1))
fi

# CPU
CPU_THREADS=$(nproc)

echo "[INFO] Threads de CPU: $CPU_THREADS"

# Disco
FREE_KB=$(df -Pk . | awk 'NR==2 {print $4}')
FREE_GB=$((FREE_KB / 1024 / 1024))

echo "[INFO] Espaco livre: aproximadamente ${FREE_GB} GB"

if [ "$FREE_GB" -lt 30 ]; then
    echo "[AVISO] Recomendamos pelo menos 30 GB livres."
    WARNINGS=$((WARNINGS + 1))
fi

echo
echo "======================================"
echo "Resultado"
echo "======================================"
echo "Erros: $ERRORS"
echo "Avisos: $WARNINGS"

if [ "$ERRORS" -gt 0 ]; then
    echo
    echo "[FALHOU] Ambiente ainda nao esta pronto."
    exit 1
fi

echo
echo "[OK] Ambiente basico aprovado."
exit 0