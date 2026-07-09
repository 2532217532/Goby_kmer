KMERIA_BIN=/home/zengjl/gitclone/KMERIA/bin/kmeria
MAMBA_LIB=/home/zengjl/miniforge3/envs/kmeriaenv/lib
KMERIA_LIB=/home/zengjl/gitclone/KMERIA/lib
export LD_LIBRARY_PATH=$MAMBA_LIB:$KMERIA_LIB
cd /mnt/SSD_R0/tmp_zengjl/Goby_kmer
for sp in $(ls 00_input/*.fna | head -2); do
  name=$(basename $sp .fna)
  echo "[\$(date)] Counting $name..."
  $KMERIA_BIN count -k 31 -m 1 -t 8 $sp -o 01_count/$name.bin
  echo "[\$(date)] Done $name"
done
