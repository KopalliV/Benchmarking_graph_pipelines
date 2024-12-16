The simulated genomes were created using the Sorghum bicolor v3.0.1 reference genome as the backbone.

Structural variants (SVs) specific to each line were incorporated based on the SV list.

The workflow involves several steps:

Generate BED Files: SV information was extracted from an Excel sheet and converted into BED format using the make_bed.sh script.

Insertions and deletions were processed separately.

Filtering Variants: Deletions were filtered directly from the Excel sheet. 

Insertions were filtered using bedtools intersect to identify variants present in at least one other assembly. 

The -f 0.90 and -F 0.90 parameters ensured a minimum 90% overlap between query and target variants. This process was repeated for all assemblies to create filtered insertion BED files. 

Combine Variants: Filtered insertion and deletion files for each assembly were combined to create final BED files for use in VISOR. 

Verify BED Files: BED files were verified using the verify_bed.py script to ensure data integrity and formatting consistency. 

Simulated Genome Creation: Final BED files were used with VISOR to create simulated genome assemblies. 

The make_genomes.sh script processed these BED files, generating VCF files using converter.py and converter3.py. These VCF files were prepared for downstream analysis with tools like Truvari. 

File Descriptions Scripts: 
make_bed.sh: Generates BED files from raw SV data. 
verify_bed.py: Verifies BED file consistency. 
make_genomes.sh: Runs VISOR to create simulated genomes and generates VCF files. 
converter.py: Converts BED files to VCF format. 
converter3.py: Converts BED files to VCF format with reference sequence details.
