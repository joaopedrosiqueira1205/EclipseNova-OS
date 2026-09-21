#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Netfilter Check"
echo "======================================"

CONFIG="/boot/config-$(uname -r)"

if [ -f "$CONFIG" ]; then
    grep -E \
    'CONFIG_NETFILTER=|CONFIG_NF_CONNTRACK=|CONFIG_NETFILTER_XTABLES=|CONFIG_IP_NF_IPTABLES=' \
    "$CONFIG" || true
else
    echo "[AVISO] Configuracao do kernel nao encontrada."
fi

echo
echo "[OK] Verificacao concluida."