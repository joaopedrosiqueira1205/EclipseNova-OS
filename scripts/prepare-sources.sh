#!/usr/bin/env bash

set -euo pipefail

# ==========================================
# SolarNexum Source Preparer 0.1
# ==========================================

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$PROJECT_ROOT/config/build-env.sh"

SOURCE_DIR="$LFS/sources"

if [ "$(uname -s)" != "Linux" ]; then
    echo "[ERRO] Execute somente no Linux."
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "[ERRO] Diretorio de fontes nao encontrado:"
    echo "$SOURCE_DIR"
    exit 1
fi

cd "$SOURCE_DIR"

echo "======================================"
echo " SolarNexum Source Preparer"
echo "======================================"

extract_source() {
    ARCHIVE="$1"
    DIRECTORY="$2"

    if [ -d "$DIRECTORY" ]; then
        echo "[OK] $DIRECTORY ja esta preparado."
        return
    fi

    if [ ! -f "$ARCHIVE" ]; then
        echo "[ERRO] Arquivo nao encontrado: $ARCHIVE"
        exit 1
    fi

    echo "[EXTRAINDO] $ARCHIVE"

    tar -xf "$ARCHIVE"

    if [ ! -d "$DIRECTORY" ]; then
        echo "[ERRO] A extracao nao criou $DIRECTORY"
        exit 1
    fi
}

extract_source "binutils-2.47.tar.xz" "binutils-2.47"
extract_source "gcc-16.2.0.tar.xz" "gcc-16.2.0"
extract_source "linux-7.1.8.tar.xz" "linux-7.1.8"
extract_source "glibc-2.44.tar.xz" "glibc-2.44"

extract_source "m4-1.4.21.tar.xz" "m4-1.4.21"
extract_source "ncurses-6.6.tar.gz" "ncurses-6.6"
extract_source "bash-5.3.tar.gz" "bash-5.3"
extract_source "coreutils-9.11.tar.xz" "coreutils-9.11"
extract_source "diffutils-3.12.tar.xz" "diffutils-3.12"
extract_source "file-5.48.tar.gz" "file-5.48"
extract_source "findutils-4.11.0.tar.xz" "findutils-4.11.0"
extract_source "gawk-5.4.1.tar.xz" "gawk-5.4.1"
extract_source "grep-3.12.tar.xz" "grep-3.12"
extract_source "gzip-1.14.tar.xz" "gzip-1.14"
extract_source "make-4.4.1.tar.gz" "make-4.4.1"
extract_source "patch-2.8.tar.xz" "patch-2.8"
extract_source "sed-4.10.tar.xz" "sed-4.10"
extract_source "tar-1.35.tar.xz" "tar-1.35"
extract_source "xz-5.8.3.tar.xz" "xz-5.8.3"

echo
echo "======================================"
echo " [OK] Fontes preparadas"
echo "======================================"