#!/usr/bin/env bash
set -euo pipefail
echo "== EclipseNova security audit =="
ss -tulpen 2>/dev/null || true
systemctl --failed --no-pager 2>/dev/null || true
journalctl -p warning -b --no-pager 2>/dev/null | tail -100 || true
find /usr -xdev -type f \( -perm -4000 -o -perm -2000 \) -print 2>/dev/null || true
