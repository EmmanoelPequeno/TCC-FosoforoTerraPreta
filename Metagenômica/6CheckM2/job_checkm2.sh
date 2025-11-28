#!/bin/bash
#SBATCH -n 16
#SBATCH --ntasks-per-node=16
#SBATCH -p batch-AMD
#SBATCH --job-name=mcz  # Job name
#SBATCH --output=checkm2_all_output_%j.log  # Log file

source activate checkm2  # If using Conda

checkm2 database --download --path /home/mayllon23025/databases/Checkm2_database

checkm2 predict --input /home/public/Terra-Preta/metagenomics/5metabat2/metabat2_bins \
                --output-directory /home/public/Terra-Preta/metagenomics/samples/checkm2_out \
                --threads 16 \
                -x fa \
                --force
