#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/ninja-1.13.2"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Ninja 1.13.2"
echo "======================================"

# Permite limitar o paralelismo com NINJAJOBS.
sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc

export NINJAJOBS=1

python3 configure.py --bootstrap --verbose

install -vm755 ninja /usr/bin/

install -vDm644 misc/bash-completion \
    /usr/share/bash-completion/completions/ninja

install -vDm644 misc/zsh-completion \
    /usr/share/zsh/site-functions/_ninja

echo
echo "[OK] Ninja 1.13.2 instalado."