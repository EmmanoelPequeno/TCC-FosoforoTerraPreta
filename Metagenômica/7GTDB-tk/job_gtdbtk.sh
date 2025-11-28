#!/bin/bash
#SBATCH -n 16
#SBATCH --ntasks-per-node=16
#SBATCH -p batch-AMD
#SBATCH --job-name=mcz  # Job name
#SBATCH --output=gtdbtk_output_%j.log  # Log file

source activate gtdbtk

gtdbtk classify_wf \
  --genome_dir /home/public/Terra-Preta/metagenomics/5metabat2/metabat2_bins \
  --out_dir /home/public/Terra-Preta/metagenomics/samples/gtdbtk_out-1 \
  --extension .fa \
  --skip_ani_screen \
  --cpus 16

