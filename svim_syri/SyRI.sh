#!/bin/bash

# Set paths to the tools and files
refgenome="/path/to/reference_genome.fa"  
qrygenome="/path/to/query_genome.fa"     
output_dir="/path/to/output_dir"         

# Step 1: Perform pairwise alignment using minimap2
minimap2 -ax asm5 --eqx $refgenome $qrygenome > $output_dir/out.sam

# Step 2: Run SyRI
syri -c $output_dir/out.sam -r $refgenome -q $qrygenome -k -F B

# Step 3: Filter and add FORMAT and SAMPLE columns to the VCF
awk 'BEGIN {OFS="\t"} { if ($0 ~ /^#/) { if ($0 !~ /^##/) print $0 "\tFORMAT\tSample"; else print $0 } else { print $0 "\tGT\t1" } }' $output_dir/input.vcf > $output_dir/output.vcf

# Step 4: Modify SVLEN INFO header field to Integer for bcftools compatibility (if necessary)
sed -i 's/SVLEN=String/SVLEN=Integer/' $output_dir/output.vcf

# Step 5: Merge multiple VCF files using Jasmine
ls *.vcf > $output_dir/filelist.txt
jasmine file_list=$output_dir/filelist.txt out_file=$output_dir/merged_syri.vcf --output_genotypes

# Step 6: Sort the merged VCF file using bcftools
bcftools sort $output_dir/merged_syri.vcf -o $output_dir/merged_syri.sorted.vcf

# Step 7: Run Truvari bench
truvari bench -b /path/to/true_set.vcf -c $output_dir/merged_syri.sorted.vcf.gz --csample Chr_sample -o $output_dir/bench_output

