#!/bin/bash

# Step 1: Combine files of each chromosome
for i in {1..10}; do
    dir="Chr$(printf "%02d" $i)"
    combined_file="Chr${i}_combined.fasta"
    cd "$dir" || exit
    cat *.fasta > "$combined_file"
    cp "$combined_file" ..
    cd ..
done

# Step 2: Build pangenomes with PGGB
k=25  # Min match length
p=95  # Percent identity
s=5000  # Segment length
D=/path/to/tempdir  # Specify the temporary directory for PGGB

input_directory="."
mkdir "flatten_k${k}_p${p}_s${s}"

for fasta_file in "$input_directory"/*.fasta.gz; do
    filename=$(basename -- "$fasta_file")
    filename_noext="${filename%.*}"
    O="${filename_noext}_k${k}_p${p}_s${s}"
    
    pggb -i "$fasta_file" -k "$k" -p "$p" -s "$s" -n 6 -D "$D" -o "$O"
    
    cd "$O"
    fasta_output="$filename_noext""_k${k}_p${p}_s${s}_flatten.fa"
    odgi flatten -i *.og -f "$fasta_output"
    cp *.fa ../"flatten_k${k}_p${p}_s${s}"
    cd ..
done

cd "flatten_k${k}_p${p}_s${s}"
cat *.fa > "flatten_k${k}_p${p}_s${s}_merged.fa"

busco -i "flatten_k${k}_p${p}_s${s}_merged.fa" -o busco_output -f -l poales_odb10 -m genome -c 28

cd ..

# Step 3:  Running Panacus
panacus histgrowth -t6 -q 0.1,0.5,1 -S INPUT.gfa > pggb_output.tsv
panacus-visualize -e pggb_output.tsv > pggb_output.pdf
# Step 3: Variant calling with vg deconstruct
vg deconstruct -p ref_path -a -e -v Chr01.gfa > Chr01.vcf

# Step 4: Split multiallelic variants
bcftools norm -m-any Chr01.vcf | bgzip > Chr01_pggb.split.vcf.gz

# Step 5: Filter variants to include only those with an alternative allele
bcftools view -i 'GT!="0"' -s Chr01_assembly -Ov -o pggb_filter.vcf Chr01_pggb.split.vcf.gz


# Step 6: Run Truvari bench
truvari bench -b path_to_trueset -c /path/Chr01_pggb.split.vcf.gz --csample Chr01_assembly -o truvari_output
