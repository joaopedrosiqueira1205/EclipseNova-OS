#!/usr/bin/env bash

# ==========================================
# SolarNexum OS - Build Environment
# ==========================================

# Local onde o SolarNexum sera construido
export LFS="${LFS:-/mnt/lfs}"

# Arquitetura da cross-toolchain
export LFS_TGT="$(uname -m)-lfs-linux-gnu"

# Notebook alvo possui 4 GB de RAM.
# Comecamos conservadoramente com 1 processo.
export BUILD_JOBS="${BUILD_JOBS:-1}"

# Diretorios principais
export SOLARNEXUM_SOURCES="$LFS/sources"
export SOLARNEXUM_TOOLS="$LFS/tools"

echo "[SolarNexum] Ambiente de build carregado"
echo "LFS: $LFS"
echo "Target: $LFS_TGT"
echo "Jobs: $BUILD_JOBS"