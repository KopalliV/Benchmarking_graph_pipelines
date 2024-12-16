#!/bin/bash

# Directories containing .fasta files (add your directories here)
directories=(
    "/path/to/dir1"
    "/path/to/dir2"
    "/path/to/dir3"
    # Add more directories as needed
)

# Reference genome file (update this with the actual path)
reference_genome="/path/to/reference_genome.fa"

# Step 1: Loop through directories and files
for dir in "${directories[@]}"; do
  for file in $dir/*.fasta; do
    # Mapping using minimap2
    minimap2 -a -x asm5 --cs -r2k -t 16 $reference_genome $dir/$file > $dir/${file%.fasta}.sam && \
    
    # Sorting and indexing with samtools
    samtools sort -m4G -@4 -o $dir/${file%.fasta}.sorted.bam $dir/${file%.fasta}.sam && \
    samtools index $dir/${file%.fasta}.sorted.bam && \
    
    # Running SVIM
    svim-asm haploid $dir/${file%.fasta} $dir/${file%.fasta}.sorted.bam $reference_genome
  done
done

# Step 2: Merge multiple VCF files using Jasmine
ls *.vcf > filelist.txt
jasmine file_list=filelist.txt out_file=merged.vcf --output_genotypes

# Sort the merged VCF file with bcftools
bcftools sort merged.vcf -o merged.sorted.vcf

# Filter out variants with 'N' in the reference allele
awk '$4 != "N"' merged.sorted.vcf > filtered_output.vcf

# Run Truvari benchmark
truvari bench -b /path_to_trueset -c filtered_output.vcf.gz --csample "Chr_assembly" -o bench_output

