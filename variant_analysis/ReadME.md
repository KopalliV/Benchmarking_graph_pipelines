Variant Analysis Pipeline

This repository contains scripts for processing VCF files, analyzing repeat content, filtering variants by size, and generating upset plots for variant comparisons. The pipeline includes the following scripts:

Scripts Overview

1. bare_incl_seq.large_small.py
   - Description: This Python script normalizes VCF files and filters variants into two categories: large and small, based on structural variant length. It processes two input VCF files and outputs filtered VCF files based on the provided filter type (`large` or `small`).
   - Usage:
     `python bare_incl_seq.large_small.py <input_vcf_1> <input_vcf_2> <filter_type>`
     - `filter_type`: Can be `large` or `small`.

2. repeat_content_analysis
   - Description: This set of shell commands analyzes repeat content in VCF files. It creates a BLAST database from a reference genome, extracts sequences from VCF files, and performs a BLAST search to identify repeats. The results are sorted and filtered based on coverage.
   - Usage: 
     - Create a BLAST database from the reference genome.
     - Extract sequences from the VCF file.
     - Perform a BLAST search to find repeat sequences.
     - Filter and sort the BLAST results by coverage and best hits.

3. upset_plots.sh
   - Description: This shell script generates upset plots using the `surpyvor` tool to visualize and compare the overlap of variants from different sources. It supports generating upset plots for both large and small variants.
