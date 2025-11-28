#!/bin/bash
#SBATCH --job-name=N95
#SBATCH --output=eggnog_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --partition=batch-AMD

# ==========================
# CONFIGURAÇÃO DE AMBIENTE
# ==========================
# Carregar Conda corretamente
source /home/mayllon23025/anacondaaa/etc/profile.d/conda.sh
conda activate eggnog

# Diretórios
PROKKA_OUTPUT="/home/public/Terra-Preta/metagenomics/6prokka_annotation/new_outputs"
EGGNOG_OUTPUT="/home/public/Terra-Preta/metagenomics/7eggnog_annotation/new_anotate"
THREADS=16

# Diretório do banco de dados eggNOG
EGGNOG_DB="/home/mayllon23025/eggnog_db"

# Criar diretórios de saída
mkdir -p ${EGGNOG_OUTPUT}/mags
mkdir -p ${EGGNOG_OUTPUT}/contigs

# ==========================
# DOWNLOAD DO BANCO DE DADOS (se não existir)
# ==========================
#if [ ! -d "${EGGNOG_DB}" ]; then
    #echo "Banco de dados eggNOG não encontrado. Fazendo download..."
    #download_eggnog_database.py --data_dir ${EGGNOG_DB}
    #echo "Download concluído!"
#fi

# ==========================
# FUNÇÃO PARA RODAR eggNOG-MAPPER
# ==========================
run_emapper() {
    local input_faa=$1
    local output_dir=$2
    local sample_name=$(basename ${input_faa%.*})

    echo "Rodando eggNOG-mapper para ${sample_name}..."

    emapper.py \
        -i ${input_faa} \
        -o ${sample_name} \
        --output_dir ${output_dir} \
        --cpu ${THREADS} \
        --data_dir ${EGGNOG_DB} \
	-m diamond \

    echo "eggNOG-mapper concluído para ${sample_name}"
}

export -f run_emapper

# ==========================
# Anotar MAGs
# ==========================
echo "Iniciando eggNOG-mapper para MAGs..."
for faa_file in ${PROKKA_OUTPUT}/mags/*/*.faa; do
    if [ -f "$faa_file" ]; then
        run_emapper "$faa_file" "${EGGNOG_OUTPUT}/mags"
    fi
done

# ==========================
# Anotar contigs
# ==========================
echo "Iniciando eggNOG-mapper para contigs..."
for faa_file in ${PROKKA_OUTPUT}/contigs/*/*.faa; do
    if [ -f "$faa_file" ]; then
        run_emapper "$faa_file" "${EGGNOG_OUTPUT}/contigs"
    fi
done

echo "Todas as anotações do eggNOG-mapper foram concluídas!"
