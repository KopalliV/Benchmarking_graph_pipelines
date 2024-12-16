**Benchmarking Pangenome Graph pipelines**

**Introduction**

This repository contains scripts used to perform analyses in the paper "Evaluation of tools and pipelines for crop pangenome variation graph construction from multiple assemblies" It is divided into the following subdirectories, each with their own README:

`pangenome_pipelines`: Scripts used for building and assembling the sorghum pangenome from multiple genomes.

`plots`: Scripts for generating the plots published in the paper.

`read_mapping`:  Scripts and resources for comparing graph-based mapping using VG Giraffe with linear reference mapping using Minimap2.

`simulations`: Scripts used to generate simulated genomes by incorporating structural variants (SVs) into the Sorghum bicolor v3.0.1 reference genome, with steps including SV extraction, filtering, verification, and use of VISOR to create VCF files for downstream analysis.

`svim_syri`: Scripts for structural variant calling using the SVIM and SYRI tools, along with variant analysis.

`variant_analysis`: Scripts used for processing VCF files, analyzing repeat content, filtering variants by size, and generating upset plots for variant comparisons.
