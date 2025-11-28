#!/bin/bash
#SBATCH -n 16                          # Total de núcleos
#SBATCH --ntasks-per-node=16           # Núcleos por nó
#SBATCH -p batch-AMD                   # Partição
#SBATCH --job-name=bowtie2_coverage    # Nome do job
#SBATCH --output=coverage_output_%j.log # Arquivo de log

# Inicializar o Conda (caminho corrigido com base no seu conda info)
source /home/mayllon23025/anacondaaa/etc/profile.d/conda.sh

# module load bowtie2 samtools metabat2  # Uncomment if needed

# Diretórios de entrada/saída
ASSEMBLY_DIR="/home/public/Terra-Preta/metagenomics/0data/remanescentes/megahit_reman"
READS_DIR="/home/public/Terra-Preta/metagenomics/0data/remanescentes/trimmed_reman"
OUTPUT_DIR="/home/public/Terra-Preta/metagenomics/0data/remanescentes/megahit_reman/cove4rrrr"
mkdir -p "$OUTPUT_DIR"

# Loop através de cada assembly
for SAMPLE_DIR in "$ASSEMBLY_DIR"/*_assembly; do
    conda activate bowtie2_env
    SAMPLE_NAME=$(basename "$SAMPLE_DIR" "_assembly")
    ASSEMBLY_FILE="$SAMPLE_DIR/final.contigs.fa"
    R1_READS="$READS_DIR/${SAMPLE_NAME}_1_trimmed_paired.fastq"
    R2_READS="$READS_DIR/${SAMPLE_NAME}_2_trimmed_paired.fastq"
    
    echo "========================================"
    echo "Processando amostra: $SAMPLE_NAME"
    echo "========================================"
    
    # --- Passo 1: Bowtie2 (usar bowtie2_env) ---
    echo "Criando índice Bowtie2..."
    bowtie2-build "$ASSEMBLY_FILE" "$OUTPUT_DIR/${SAMPLE_NAME}_index"
    
    echo "Mapeando reads..."
    bowtie2 -x "$OUTPUT_DIR/${SAMPLE_NAME}_index" \
            -1 "$R1_READS" -2 "$R2_READS" \
            --threads 16 \
            > "$OUTPUT_DIR/${SAMPLE_NAME}.sam"
    conda deactivate
    
    # --- Passos 2-4: Samtools (usar samtools_env) ---
    conda activate samstool
    echo "Convertendo SAM para BAM..."
    samtools view -@ 16 -bS "$OUTPUT_DIR/${SAMPLE_NAME}.sam" -o "$OUTPUT_DIR/${SAMPLE_NAME}.bam"
    
    echo "Ordenando BAM..."
    samtools sort -@ 16 "$OUTPUT_DIR/${SAMPLE_NAME}.bam" -o "$OUTPUT_DIR/${SAMPLE_NAME}.sorted.bam"
    samtools index -@ 16 "$OUTPUT_DIR/${SAMPLE_NAME}.sorted.bam"
    
    echo "Calculando profundidade..."
    jgi_summarize_bam_contig_depths \
        --outputDepth "$OUTPUT_DIR/${SAMPLE_NAME}_depth.txt" \
        "$OUTPUT_DIR/${SAMPLE_NAME}.sorted.bam"
    conda deactivate
    
    # --- Limpeza ---
    echo "Removendo arquivos temporários..."
    rm -f "$OUTPUT_DIR/${SAMPLE_NAME}.sam" "$OUTPUT_DIR/${SAMPLE_NAME}.bam"
    rm -f "$OUTPUT_DIR/${SAMPLE_NAME}_index"*
    
    echo "Finalizado: $SAMPLE_NAME"
    echo "----------------------------------------"
done

echo "Processamento concluído!"
echo "Arquivos de cobertura salvos em: $OUTPUT_DIR"
