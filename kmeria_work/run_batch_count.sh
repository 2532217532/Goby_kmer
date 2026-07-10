#!/usr/bin/bash
# Batch k-mer counting for all 36 species
# Run from /mnt/SSD_R0/tmp_zengjl/Goby_kmer

set -euo pipefail

KMERIA_BIN=/home/zengjl/gitclone/KMERIA/bin/kmeria
MAMBA_LIB=/home/zengjl/miniforge3/envs/kmeriaenv/lib
KMERIA_LIB=/home/zengjl/gitclone/KMERIA/lib
export LD_LIBRARY_PATH=$MAMBA_LIB:$KMERIA_LIB

cd /mnt/SSD_R0/tmp_zengjl/Goby_kmer

MAX_PARALLEL=12
COUNTER=0

for sp_fa in 00_input/*.fna; do
    name=$(basename "$sp_fa" .fna)
    out_bin="01_count/${name}.bin"

    if [[ -f "$out_bin" ]]; then
        echo "[SKIP] $name already counted"
        continue
    fi

    echo "[$(date)] Starting $name..."
    $KMERIA_BIN count -k 31 -m 1 -t 16 "$sp_fa" -o "$out_bin" \
        2>&1 | tail -5 &

    COUNTER=$((COUNTER + 1))

    if [[ $COUNTER -ge $MAX_PARALLEL ]]; then
        wait -n
        COUNTER=$((COUNTER - 1))
    fi
done

wait
echo "[$(date)] All k-mer counting complete!"

ls 01_count/*.bin > databases.txt
echo "databases.txt created"
