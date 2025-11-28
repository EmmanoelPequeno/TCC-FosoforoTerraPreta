#!/bin/bash

input="merged_abundance_table_2.txt"  # substitua pelo seu arquivo

# Definir níveis e nomes de arquivos
levels=("k" "p" "c" "o" "f" "g" "s")
names=("kingdom" "phylum" "class" "order" "family" "genus" "species")

# Obtem o número de amostras (colunas após clade_name)
num_samples=$(awk 'NR==2{print NF-1}' "$input")

for i in "${!levels[@]}"; do
    level="${levels[$i]}"
    name="${names[$i]}"
    outfile="${name}.tsv"

    echo "Processando nível: $name"

    awk -v lvl="$level" -v samples="$num_samples" '
    BEGIN { OFS="\t" }
    # Ignora linhas de comentário
    /^#/ { next }
    NR==1 { next }  # pula cabeçalho
    {
        split($1, taxa, "|")
        key=""
        for(j=1;j<=length(taxa);j++){
            split(taxa[j], t, "__")
            if(t[1]==lvl){ key=t[2] }
        }
        if(key=="") next
        for(k=2;k<=NF;k++){
            abund[key,k-1]+=$k
        }
    }
    END {
        # Cabeçalho
        printf "taxon"
        for(i=1;i<=samples;i++){ printf "\tsample"i }
        print ""
        # Imprime abundâncias
        for(taxon in abund){
            printf taxon
            for(i=1;i<=samples;i++){
                printf "\t" ((i in abund[taxon]) ? abund[taxon,i] : 0)
            }
            print ""
        }
    }
    ' "$input" > "$outfile"
done

