<p align="center">
  <img src="intro_imagem.png" alt="Descrição da imagem" width="1000"/>
</p>

<h1 align="center"> INVESTIGAÇÃO DE PROPRIEDADES FÍSICO-QUÍMICAS E MICROBIANAS RELEVANTES PARA BIODISPONIBILIZAÇÃO DE FÓSFORO EM TERRA PRETA AMAZÔNICA VIA ANÁLISES METAGENÔMICAS E ESPECTROSCOPIA POR LUZ SÍNCROTRON 🌱🦠 </h1>

Este repositório, dedidco a abrigar os resultados do trabalho de conclusão de curso da Ilum Escola de Ciência, faculdade vinculada ao Centro Nacional de Pesquisa em Energia e materiais (CNPEM), tendo como pesquisadores:

- Davi José Araújo Pereira (https://github.com/davijosearaujo) ⚛️

- Mayllon Emmanoel Pequeno (https://github.com/EmmanoelPequeno) 🦠

- Emelyn Alves (https://github.com/emelyn23017) (Colaboradora) 🌱

- Izaque Júnior Oliveira Silva (https://github.com/Izaque-Junior) (Colaborador) 🧪


Este repositório reúne dados, scripts e análises relacionadas ao estudo da Terra Preta Amazônica como sistema socioambiental de referência para a investigação da biodisponibilidade de fósforo. O objetivo geral desta pesquisa foi Investigar os mecanismos envolvidos na biodisponibilização de fósforo na Terra Preta Amazônica, por meio da identificação e anotação funcional de microrganismos solubilizadores de fósforo e da análise de suas interações com a matriz físico-química do solo, integrando técnicas avançadas de espectroscopia por luz síncrotron, fracionamento de fósforo e análises metagenômicas. Este respositório está divido em Três pastas principais:

- **Metagenômica** (caminho da pasta):  
  Destinada a abrigar os arquivos de estatísticas e *scripts* associados às análises de bioinformática.  
  A pasta está dividida em subpastas de acordo com cada ferramenta e/ou método utilizado nas análises metagenômicas:

  - `0dados/` – Contém dados utilizados nas análises. Nenhum processamento é feito aqui. Esta pasta funciona como referência para todas as etapas subsequentes.
    - Fonte: <a> https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=1262372 </a>
  - `1.1FastQC/` – Inclui os relatórios individuais gerados pelo FastQC, permitindo avaliar, por exemplo, qualidade por base, Conteúdo GC, adaptadores ect.
    - Fonte: <a> https://github.com/s-andrews/FastQC </a>
  - `1.2MultiQC/` – Dados do FastQC sumarizados. Agrupamento de todos os relatórios em um único arquivo.
    - Fonte: <a> https://github.com/MultiQC/MultiQC </a>
  - `2Trimmomatic/` – Contém dados do processamento pelo Trimmomatic, incluindo, por exemplo, remoção de adaptadores, cortes de baixa qualidade e descarte de <i> reads </i> muito curtas
    - Fonte: <a> https://github.com/usadellab/Trimmomatic </a>
  - `3Metaphlan4/` – Contém os arquivos de saída do MetaPhlAn4 com composições taxonômicas microbianas identificadas nas <i> reads </i> após o Trimmomatic. Inclui tabelas e perfis de abundância relativa.
    - Fonte: <a> https://github.com/biobakery/MetaPhlAn <\a>
  - `4Megahit/` – Dados de <i> contigs </i> montadas
    - Fonte: <a> https://github.com/voutcn/megahit </a>
  - `5.1Bowtie2/` – Dados do mapeamento das <i> reads </i> para as <i> contigs </i>
    - Fonte: <a> https://github.com/BenLangmead/bowtie2 </a>
  - `5.2Samtools/` – Dados de processamento dos arquivos SAM e BAM, incluindo conversões, ordenamentos, indexação e cálculo de cobertura.
    - Fonte: <a> https://github.com/samtools/samtools </a>
  - `5.3MetaBat2/` – Dados de agrupamento de <i> contigs </i> em genomas individuais
    - Fonte: <a> anaconda.org/bioconda/metabat2 </a>
  - `6CheckM2/` – Contém os relatórios gerados pelo CheckM2 indicando a qualidade dos genomas agrupados.
    - Fonte: <a> https://github.com/chklovski/CheckM2 </a>
  - `7GTDB-tk/` – Contém os arquivos de saída do GTDB-tk, definindo a taxonômia dos genomas gerados com base no banco de dados GTDB. Inclui tabelas de qualidade e árvores de referência.
    - Fonte: <a> https://github.com/Ecogenomics/GTDBTk </a>
  - `8.1Prokka/` – Contém os arquivos de anotação funcional inicial.
    - Fonte: <a> https://github.com/tseemann/prokka </a>
  - `8.2eggNOG/` – Contém os arquivos de anotação funcional e categorização metabólica.
    - Fonte: <a> https://github.com/eggnogdb/eggnog-mapper </a>
  - `8.3FeGenie/` – Contém os arquivos de análises de genes ligados ao cilo do Ferro. Inclui <i> heatmpas </i>, tabelas funcionais e genes anotados.
    - Fonte: <a> https://github.com/Arkadiy-Garber/FeGenie </a>
  - `9.1InterProScan/` – Contém os arquivos de anotação funcional com foco em domínios conservados e assinaturas funcionais.
    - Fonte: <a> https://github.com/ebi-pf-team/interproscan </a>
  - `9.2MAFFT/` – Contém os arquivos de alinhamento múltiplo das sequências do gene <i> gcd </i> (marcador de microrganismos solubilizadores de fósforo).
    - Fonte: <a> https://anaconda.org/channels/bioconda/packages/mafft/overview </a>
  - `9.3IQ-TREE/` – Contém os arquivos relacionados à inferência filogenética do gene <i> gcd </i>. Inclui arquivos como .treefile, .log e .iqtre
    - Fonte: <a> https://github.com/iqtree/iqtree3 </a>

  
- **Espectroscopia** (caminho da pasta): Destinada a abrigar os arquivos de tratamento de dados obtidos por meio ds Microfluorescência de Raios X ($\mu$-SXRF) e Estrutura de Absorção de Raios X Próxima à Borda (XANES).
- `A11/` – Fluorescência de raios X. Amostra de Terra Preta Amazônica de 0 a 10 cm. Varredura de 50 x 50 $\mu$m$^2$.
- `A12/` – Fluorescência de raios X. Amostra de Terra Preta Amazônica de 0 a 10 cm. Varredura de 100 x 100 $\mu$m$^2$.
- `B11/` – Fluorescência de raios X. Amostra de Terra Preta Amazônica de 10 a 20 cm. Varredura de 50 x 50 $\mu$m$^2$.
- `B12/` – Fluorescência de raios X. Amostra de Terra Preta Amazônica de 10 a 20 cm. Varredura de 100 x 100 $\mu$m$^2$.
- `B13/` – Fluorescência de raios X. Amostra de Terra Preta Amazônica de 10 a 20 cm. Varredura de 100 x 100 $\mu$m$^2$. Região de interesse deslocada em relação ao arquivo anterior.
- `images_tiff` – Esse diretório contém, para cada amostra, os mapas de cada elemento e todas as combinações par a par dos elementos identificados. Todas as imagens estão com as devidas legendas e escalas.

- **Fracionamento** (caminho da pasta): Destinada a abrigar os protocolos e arquivos de tratamento dos dados obtidos a partir das análises químicas realizadas em laboratório.
- `03-10(H2O)-Pres` - Contém os dados das medidas realizadas no espectrofotômetro UV-Vis para o fósforo residual (P-res) em H2O realizadas no dia 03/10/25.
- `22-09(HCl0,5M)`- Contém os dados das medidas realizadas no espectrofotômetro UV-Vis para o fósforo em resina (P-RTA) em HCl 0,5 M realizadas no dia 22/09/25.
- `23-09(NaHCO3)-Pi` - Contém os dados das medidas realizadas no espectrofotômetro UV-Vis para o fósforo inorgânico em NaHCO3 (pH ajustado pra 8,5) realizadas no dia 23/09/2025
- `23-09(NaHCO3)-Pt` - Contém os dados das medidas realizadas no espectrofotômetro UV-Vis para o fósforo total em NaHCO3 (pH ajustado pra 8,5) realizadas no dia 23/09/2025
- `24-09(NaOH-0,1M)-Pi` - Contém os dados das medidas realizadas no espectrofotômetro UV-Vis para o fósforo inorgânico em NaOH 0,1 M realizadas no dia 24/09/2025
- `24-09(NaOH-0,1M)-Pt` - Contém os dados das medidas realizadas no espectrofotômetro UV-Vis para o fósforo total em NaOH 0,1 M realizadas no dia 24/09/2025
- `25-09(HCl1M)-Pi` - Contém os dados das medidas realizadas no espectrofotômetro UV-Vis para o fósforo inorgânico em HCl 1 M realizadas no dia 25/09/2025
- `25-09(HCl1M)-Pt` - Contém os dados das medidas realizadas no espectrofotômetro UV-Vis para o fósforo total em HCl 1 M realizadas no dia 25/09/2025
- `25_09_placa(HCl1M)_Pi_Pt` Contém os dados das medidas realizadas no leitor de placa de 96 poços para o fósforo inorgânico e total em HCl 1 M realizadas no dia 25/09/2025
- `26-09(NaOH0,5M)-Pi` - Contém os dados das medidas realizadas no espectrofotômetro UV-Vis para o fósforo inorgânico em NaOH 0,5 M realizadas no dia 26/09/2025
- `26-09(NaOH0,5M)-Pt` - Contém os dados das medidas realizadas no espectrofotômetro UV-Vis para o fósforo total em NaOH 0,5 M realizadas no dia 26/09/2025

Os resultados da pesquisa indicaram:
- A alta taxa de matéria orgânica se dá pelo manejo e cultivo intencional da TPA, realizado por povos originários e seus descendentes.
- Ferro foi o elemento medido em maior abundância na fluorescência de raios X.
- O ambiente ácido e à alta taxa de matéria orgânica mantém um óxido de ferro pouco cristalino com alta capacidade de adsorção de P: a ferrihidrita.
- A maior parte do P está em formas orgânicas na fração moderadamente lábil, sendo a maior parte dessa fração composta por fósforo ligado ao ferro.
- O P prontamente disponível representa uma fração pequena em relação ao total, mas o P lábil representa cerca de 25% do total de P.
- Existem mecanismos biológicos capazes de contrapor a tendência química de adsorver fósforo.

Obrigado pelo interesse!

Link página da Ilum: https://ilum.cnpem.br <br>
Link página do CNPEM: https://cnpem.br <br>
Link página do LNLS: https://lnls.cnpem.br <br>
Link página do CENA-USP: http://www.cena.usp.br <br>
