#!/bin/bash
# Step 6: Compare mappings and compute cumulative rates

# Annotate Minimap2 mappings for comparison
vg annotate -a minimap_mappings.gam -m -x updated_graph.gbz > annotated_minimap.gam

# Compare mappings using vg gamcompare
vg gamcompare -s -r 100 -T annotated_minimap.gam simulated_reads.gam > minimap_scores.tsv

# Generate cumulative alignment and correctness rates
echo -e "min_mapQ\treads_aligned\treads_aligned_correctly" > minimap_cumulative_rates.tsv
awk 'NR>1 {aligned[$2]++} NR>1&&$1==1 {correct[$2]++} 
     END {OFS="\t"; for (i in aligned) print i, aligned[i], correct[$2]}' minimap_scores.tsv > temp_aligned_correct.tsv

# Sort results by minimum mapping quality in descending order
sort -nrk1,1 temp_aligned_correct.tsv > sorted_aligned_correct.tsv

# Compute cumulative statistics
awk '{OFS="\t"; cum_aligned+=$2; cum_correct+=$3; print $1, cum_aligned, cum_correct}' sorted_aligned_correct.tsv >> minimap_cumulative_rates.tsv

