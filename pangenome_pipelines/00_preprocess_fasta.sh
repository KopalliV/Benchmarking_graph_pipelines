#!/bin/bash
# Preprocess FASTA files: split chromosomes and append file names to headers
for file in *.fasta; do base_name="${file%.fasta}" awk -v fname="$base_name" '^ /^>/ { if (f) close(f) f = substr($1, 2) ".fasta" print $0 "_" fname > f next
    }
    { print >> f
    }
  ' "$file"
done
