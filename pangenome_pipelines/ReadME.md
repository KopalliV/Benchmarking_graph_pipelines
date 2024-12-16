This repository contains scripts for building and analyzing sorghum pangenomes. 

Scripts: - 

`00_preprocess_fasta.sh`: Preprocesses FASTA files by splitting chromosomes and appending file names to headers. 

`01_cactus.sh`: Constructs pangenomes using Minigraph-Cactus, performs variant calling, and runs Panacus for analysis. 

`02_minigraph.sh`: Builds pangenomes with Minigraph, performs variant calling, and processes GFA files. 

`03_pggb.sh`: Constructs pangenomes with PGGB, performs variant calling, and benchmarks results with Truvari.

`04_coverage_and_missing_genes.sh`: Analyzes coverage and missing genes using Minimap2 and Liftoff.
