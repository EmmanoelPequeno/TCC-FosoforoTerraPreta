#!/bin/bash
#SBATCH -J gnx       # Job name
#SBATCH -p batch-AMD                 # Partition/queue
#SBATCH -n 16                         # Number of nodes
#SBATCH --ntasks-per-node=16         # 10 CPU cores per node
#SBATCH --output=megahit_%j.log      # Output log (%j = job ID)
#SBATCH --error=megahit_%j.err       # Error log

# Activate environment (adjust if needed)
source activate megahit

# Directory with trimmed FASTQ files
INPUT_DIR="/home/public/Terra-Preta/metagenomics/0data/remanescentes/trimmed_reman"
OUTPUT_DIR="/home/public/Terra-Preta/metagenomics/0data/remanescentes/megahit_reman"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through all R1 paired files (assuming naming format: SRR*_1_trimmed_paired.fastq.gz)
for R1_FILE in "$INPUT_DIR"/SRR337509*_1_trimmed_paired.fastq; do
  # Get sample ID (e.g., SRR33750934)
  SAMPLE_ID=$(basename "$R1_FILE" | cut -d '_' -f 1)
  
  # Define R2 file (paired-end)
  R2_FILE="$INPUT_DIR/${SAMPLE_ID}_2_trimmed_paired.fastq"
  
  # Output subdirectory for this sample
  SAMPLE_OUT="$OUTPUT_DIR/${SAMPLE_ID}_assembly"
  
  echo "Processing sample: $SAMPLE_ID"
  echo "R1: $R1_FILE"
  echo "R2: $R2_FILE"
  echo "Output: $SAMPLE_OUT"

  # Run MEGAHIT with soil-specific optimizations
  megahit \
    -1 "$R1_FILE" \
    -2 "$R2_FILE" \
    -o "$SAMPLE_OUT" \
    --kmin-1pass \          # Reduce memory usage for low-depth sequencing
    --presets meta-large \  # Optimized for high-biodiversity (soil)
    --cleaning-rounds 1 \   # Less aggressive pruning (retains more contigs)

  echo "Finished assembly for $SAMPLE_ID"
  echo "----------------------------------"
done

echo "All assemblies completed!"

