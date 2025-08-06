This repository contains scripts for building and analyzing sorghum pangenomes. 

Scripts: - 

`00_preprocess_fasta.sh`: Preprocesses FASTA files by splitting chromosomes and appending file names to headers. 

`01_cactus.sh`: Constructs pangenomes using Minigraph-Cactus, performs variant calling, and runs Panacus for analysis. 

`02_minigraph.sh`: Builds pangenomes with Minigraph, performs variant calling, and processes GFA files and runs Panacus for analysis. 

`03_pggb.sh`: Constructs pangenomes with PGGB, runs Panacus for analysis, performs variant calling, and benchmarks results with Truvari.

`04_coverage_and_missing_genes.sh`: Analyzes coverage and missing genes using Minimap2 and Liftoff.

`05_kmer_counts`: Extracts complete BUSCO genes, generates 21-mers from their CDS, maps them to both the reference and graph.flatten.fasta using BWA, and classifies mappings as unique or multi-copy.
