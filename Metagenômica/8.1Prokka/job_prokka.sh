#!/bin/bash
#SBATCH --job-name=$
#SBATCH --output=prokka_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --partition=batch-AMD

# Carregar módulos ou ambiente Conda
conda activate base

# Diretórios de entrada e saída
MAGS_DIR="/home/public/Terra-Preta/metagenomics/5metabat2/metabat2_bins"
CONTIGS_DIR="/home/public/Terra-Preta/metagenomics/3megahit/megahit_assemblies/1kbp_filtered_contigs"
PROKKA_OUTPUT="/home/public/Terra-Preta/metagenomics/6prokka_annotation/new_outputs"
THREADS=16

# Criar diretórios de saída
mkdir -p ${PROKKA_OUTPUT}/mags
mkdir -p ${PROKKA_OUTPUT}/contigs

# Função para rodar Prokka
run_prokka() {
    local input_file=$1
    local output_dir=$2
    local sample_name=$(basename ${input_file%.*})
    
    echo "Anotando ${sample_name}..."
    
    prokka \
        --outdir ${output_dir}/${sample_name} \
        --prefix ${sample_name} \
        --cpus ${THREADS} \
        --metagenome \
        --centre TP \
        --force \
        ${input_file}
    
    echo "Anotação de ${sample_name} concluída"
}

export -f run_prokka

# Anotar MAGs
echo "Iniciando anotação das MAGs..."
for mag_file in ${MAGS_DIR}/*.fa; do
    if [ -f "$mag_file" ]; then
        run_prokka "$mag_file" "${PROKKA_OUTPUT}/mags"
    fi
done

# Anotar contigs das montagens
echo "Iniciando anotação dos contigs..."
for contig_file in ${CONTIGS_DIR}/*.fasta; do
    if [ -f "$contig_file" ]; then
        run_prokka "$contig_file" "${PROKKA_OUTPUT}/contigs"
    fi
done

echo "Todas as anotações foram concluídas!"
