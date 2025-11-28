#!/bin/bash
#SBATCH -n 1
#SBATCH --ntasks-per-node=8
#SBATCH -p batch-AMD
#SBATCH --job-name=i
#SBATCH --output=mpa_output_%j.log

# Load Conda environment
source activate mpa

# Diretório com os trimmed FASTQ
INPUT_DIR="/home/public/Terra-Preta/metagenomics/0data/remanescentes/trimmed_reman"

# Diretório de saída dos perfis
OUTPUT_DIR="/home/public/Terra-Preta/metagenomics/0data/remanescentes/trimmed_reman/mpa_taxonomy"
mkdir -p "$OUTPUT_DIR"

# Lista de samples únicos (SRR33750934, SRR33750935, etc.)
samples=$(ls "$INPUT_DIR"/*_1_trimmed_paired.fastq | xargs -n 1 basename | sed 's/_1_trimmed_paired.fastq//' | sort | uniq)

# Loop em cada sample
for s in $samples; do
    echo "Processando $s ..."

    # Arquivos FASTQ do sample (paired e unpaired)
    f1_paired="$INPUT_DIR/${s}_1_trimmed_paired.fastq"
    f2_paired="$INPUT_DIR/${s}_2_trimmed_paired.fastq"
    f1_unpaired="$INPUT_DIR/${s}_1_trimmed_unpaired.fastq"
    f2_unpaired="$INPUT_DIR/${s}_2_trimmed_unpaired.fastq"

    # Cria uma lista com todos os arquivos existentes
    files_to_run=""
    for f in "$f1_paired" "$f2_paired" "$f1_unpaired" "$f2_unpaired"; do
        if [ -f "$f" ]; then
            files_to_run="${files_to_run},$f"
        fi
    done
    # Remove a primeira vírgula
    files_to_run="${files_to_run:1}"

    # Arquivo de saída
    output_file="$OUTPUT_DIR/${s}_profiled.txt"

    # Rodar MetaPhlAn
    metaphlan $files_to_run --input_type fastq -o "$output_file" --mapout "$OUTPUT_DIR/${s}_map.txt" --nproc 16
done


