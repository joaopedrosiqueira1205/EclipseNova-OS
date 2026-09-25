#!/usr/bin/env bash
set -euo pipefail
echo "== EclipseNova security baseline =="
printf '%-28s %s\n' "ASLR" "$(sysctl -n kernel.randomize_va_space 2>/dev/null || echo '?')"
printf '%-28s %s\n' "Root login SSH" "$(sshd -T 2>/dev/null | awk '/^permitrootlogin/{print $2;exit}' || true)"
echo "Portas:"
ss -tulpen 2>/dev/null || true
echo "Servicos falhos:"
systemctl --failed --no-pager 2>/dev/null || true
