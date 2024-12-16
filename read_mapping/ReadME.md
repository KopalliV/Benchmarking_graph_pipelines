Graph vs Linear Reference Mapping  

This repository contains scripts and resources for comparing graph-based mapping using VG Giraffe with linear reference mapping using Minimap2. 

The pipeline performs read simulation,mapping, and evaluation to assess alignment accuracy and correctness. 

Pipeline Overview The pipeline involves the following key steps: 

`01_merge_gaphs`: Combine chromosome-level GFA files into a unified graph. 

`02_generate_indexes`: Create indexes required for graph mapping using VG Giraffe. 

`03_simulate_reads`: Simulate reads from the pangenome graph. 

`04_mapping_giraffe`: Map simulated reads to the graph using VG Giraffe. 

`05_mapping_minimap2`: Extract linear references from the graph and map reads using Minimap2.

`06_compare_results`: Compare mapping results to assess accuracy and correctness.
