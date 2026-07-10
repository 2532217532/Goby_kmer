#!/usr/bin/bash
# Build population k-mer matrix using kctm
# Run from /mnt/SSD_R0/tmp_zengjl/Goby_kmer

set -euo pipefail

KMERIA_BIN=/home/zengjl/gitclone/KMERIA/bin/kmeria
MAMBA_LIB=/home/zengjl/miniforge3/envs/kmeriaenv/lib
KMERIA_LIB=/home/zengjl/gitclone/KMERIA/lib
export LD_LIBRARY_PATH=$MAMBA_LIB:$KMERIA_LIB

cd /mnt/SSD_R0/tmp_zengjl/Goby_kmer

echo "[$(date)] Starting kctm matrix building..."
echo "[$(date)] Databases: $(wc -l < databases.txt)"
echo "[$(date)] Output: 02_kctm/matrix"

$KMERIA_BIN kctm \
    -i databases.txt \
    -o 02_kctm/matrix \
    -j 16 \
    -m 1 \
    -v 2>&1

echo "[$(date)] kctm complete!"
