#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " EclipseNova OS - Security Permissions"
echo "======================================"

[ -f /etc/shadow ] &&
    chmod 640 /etc/shadow

[ -f /etc/gshadow ] &&
    chmod 640 /etc/gshadow

[ -f /etc/passwd ] &&
    chmod 644 /etc/passwd

[ -f /etc/group ] &&
    chmod 644 /etc/group

[ -d /root ] &&
    chmod 700 /root

[ -d /etc/NetworkManager/system-connections ] &&
    chmod 700 /etc/NetworkManager/system-connections

echo "[OK] Permissoes verificadas."