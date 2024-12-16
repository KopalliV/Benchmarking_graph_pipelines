#!/bin/bash

# Step1: Build pangenome for the chromosome using minigraph
REFERENCE_FILE="Chr01_reference.fasta"
GFA_FILE="Chr01.gfa"
FILE_LIST="list.txt"

minigraph -cxggs -t16 "$REFERENCE_FILE" Chr01_*.fasta > "$GFA_FILE"

# Step2: Call variants from GFA file
ls Chr01_*.fasta > "$FILE_LIST"

while IFS= read -r fa_file; do
    output_bed=$(basename "$fa_file" .fasta).bed
    ../../minigraph -cxasm --call -t16 "$GFA_FILE" "$fa_file" > "$output_bed"
done < "$FILE_LIST"

# Step3: Convert GFA file and add paths
txt="list.txt"
txt2="${txt%.txt}2.txt"
converted_gfa="Chr01_converted.gfa"
output="Chr01_paths.gfa"
vcf="Chr01.vcf"

sed 's/.fasta//g' "$txt" > "$txt2"
vg convert -r 0 -g "$GFA_FILE" -f > "$converted_gfa"
cat "$converted_gfa" <(paste *.bed | ../../mgutils.js path "$txt2" - | sed 's/s//g') > "$output"

# Step4: Running Panacus
panacus histgrowth -t6 -q 0.1,0.5,1 -S "$output" > Chr01_minigraph_output.tsv
panacus-visualize -e Chr01_minigraph_output.tsv > Chr01_minigraph_output.pdf

# Step5: Call variants for the updated GFA file
vg deconstruct -p 'ref_path' -a -v -t 16 "$output" > "$vcf"
