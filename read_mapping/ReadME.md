Graph vs Linear Reference Mapping  

This repository contains scripts and resources for comparing graph-based mapping using VG Giraffe with linear reference mapping using Minimap2. 
The pipeline performs read simulation,mapping, and evaluation to assess alignment accuracy and correctness. 

Pipeline Overview The pipeline involves the following key steps: 
Merging Graph Files: Combine chromosome-level GFA files into a unified graph. 
Index Generation: Create indexes required for graph mapping using VG Giraffe. 
Read Simulation: Simulate reads from the pangenome graph. 
Graph Mapping: Map simulated reads to the graph using VG Giraffe. 
Linear Reference Mapping: Extract linear references from the graph and map reads using Minimap2.
Comparison and Evaluation: Compare mapping results to assess accuracy and correctness.
