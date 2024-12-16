#!/bin/bash

# Step 1: Create the SEQ file for Minigraph-Cactus
for dir in ChromosomeDirectories/*; do
    cd "$dir" || exit
    for file in *.fasta; do
        echo -e "${file%.fasta}\t/path/to/data/$dir/$file"
    done > "${dir}_seq_file.txt"
    cd ..
done

# Step 2: Run Minigraph-Cactus for each chromosome directory
for dir in ChromosomeDirectories/*; do
    seq_file="$dir/${dir}_seq_file.txt"
    output_dir="$dir/output"
    cactus-pangenome "$dir/json" "$seq_file" \
        --outDir "$output_dir" \
        --outName "${dir}_output" \
        --reference "${dir}_reference" \
        --workDir temp/ \
        --gfa --viz --draw --logFile --gbz --og cactus.log
done

# Step 3: Run Panacus for analyzing GFA files
panacus histgrowth -t6 -q 0.1,0.5,1 -S input.gfa > output.tsv
panacus-visualize -e output.tsv > output.pdf

# Step 4: Perform variant calling using vg deconstruct
vg deconstruct -a -e -v -p "reference_path" "input.gfa" > "output.vcf"

# Step 5: Normalize and filter variants
bcftools norm -m-any "output.vcf" > "output.split.vcf"
bcftools view -i 'GT!="0"' -s "sample_name" -Ov -o "filtered_output.vcf" "output.split.vcf"

# Step 6: Benchmarking using Truvari
truvari bench \
    -b reference.vcf.gz \
    -c "filtered_output.vcf" \
    -s 100 -S 100 \
    -o truvari_output

Repeat Steps 1-5 for every chromosome,
Repeat step 6 for every assembly in every chromosome

