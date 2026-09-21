#!/usr/bin/env bash
set -euo pipefail

SOURCE="/sources/vim-9.2.1025"

if [ "$(id -u)" -ne 0 ]; then
    echo "[ERRO] Execute dentro do chroot como root."
    exit 1
fi

cd "$SOURCE"

echo "======================================"
echo " SolarNexum OS - Vim 9.2.1025"
echo "======================================"

echo '#define SYS_VIMRC_FILE "/etc/vimrc"' \
    >> src/feature.h

./configure --prefix=/usr

make -j1

chown -R tester .

sed '/test_plugin_glvs/d' \
    -i src/testdir/Make_all.mak

su tester -c \
    "TERM=xterm-256color LANG=en_US.UTF-8 make -j1 test" \
    &> vim-test.log

grep "FAILED:" vim-test.log || true

make install

ln -sv vim /usr/bin/vi

for L in /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 "$(dirname "$L")/vi.1"
done

ln -sv ../vim/vim92/doc \
    /usr/share/doc/vim-9.2.1025

cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1

set nocompatible
set backspace=2
set mouse=
syntax on

if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF

echo
echo "[OK] Vim 9.2.1025 instalado."