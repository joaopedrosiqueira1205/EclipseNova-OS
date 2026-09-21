#!/usr/bin/env bash
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

echo "======================================"
echo " SolarNexum OS - Profile"
echo "======================================"

cat > /etc/profile << "EOF"
# Begin /etc/profile

for i in $(locale); do
    unset ${i%=*}
done

if [[ "$TERM" = linux ]]; then
    export LANG=C.UTF-8
else
    source /etc/locale.conf

    for i in $(locale); do
        key=${i%=*}

        if [[ -v $key ]]; then
            export $key
        fi
    done
fi

# End /etc/profile
EOF

echo
echo "[OK] /etc/profile criado."