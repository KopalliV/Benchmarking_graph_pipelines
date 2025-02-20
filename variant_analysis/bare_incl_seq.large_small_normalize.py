import sys

def process_vcf(input_vcf_1, input_vcf_2, filter_type):
    # Process the first input file (header)
    for l in open(input_vcf_1):
        if l.startswith("#"):
            print(l.rstrip())  # Print header lines as they are

    # Process the second input file
    for l in open(input_vcf_2):
        if l.startswith("#"):
            continue  # Skip header lines
        else:
            l_arr = l.rstrip().split("\t")

            # Extract required fields
            ch = l_arr[0]      # Chromosome
            pos = l_arr[1]     # Position
            idx = l_arr[2]     # Index/ID
            ref = l_arr[3]     # Reference allele
            alt = l_arr[4]     # Alternative allele
            qual = "."         # Quality
            flt = "."          # Filter
            svt = ""           # Structural Variant Type
            en = ""            # End position (to be calculated)
            svl = ""           # Structural Variant Length

            # Determine the type of variant based on the lengths of ref and alt
            if len(ref) < len(alt):  # Insertion
                svt = "INS"
                svl = str(len(alt) - len(ref))  # SVLEN is the length difference
                en = pos  # For insertions, END position is the same as POS
            elif len(ref) > len(alt):  # Deletion
                svt = "DEL"
                svl = str(len(ref) - len(alt))  # SVLEN is the length difference
                en = str(int(pos) + len(ref) - 1)  # END = POS + SVLEN - 1
            else:  # SNP
                svt = "SNP"  # Assuming SNP if ref and alt are the same length
                svl = "0"  # SVLEN for SNPs
                en = pos  # END is the same as POS for SNPs

            # Build the description (INFO field), including the calculated END
            des = ";".join(["SVTYPE=" + svt, "END=" + en, "SVLEN=" + svl])

            # Format and genotype
            fmt = "GT"
            geno = "1/1"

            # If in "normalize" mode, just print the variant without filtering
            if filter_type == "normalize":
                print("\t".join([ch, pos, idx, ref, alt, qual, flt, des, fmt, geno]))

            # Apply filtering if the filter type is "large" or "small"
            elif filter_type == "large":
                if (svt == "INS" and abs(int(svl)) >= 100 or svt == "DEL" and abs(int(svl)) >= 100):
                    # Print the filtered variant in VCF format
                    print("\t".join([ch, pos, idx, ref, alt, qual, flt, des, fmt, geno]))

            elif filter_type == "small":
                if (svt == "INS" and abs(int(svl)) <= 50 or svt == "DEL" and abs(int(svl)) <= 50 or svt == "SNP"):
                    # Print the filtered variant in VCF format
                    print("\t".join([ch, pos, idx, ref, alt, qual, flt, des, fmt, geno]))

            else:
                print("Invalid filter type. Use 'large', 'small', or 'normalize'.")
                sys.exit(1)


# Ensure that the script receives two input files and a filter type
if len(sys.argv) != 4:
    print("Usage: python script.py <input_vcf_1> <input_vcf_2> <filter_type>")
    sys.exit(1)

input_vcf_1 = sys.argv[1]
input_vcf_2 = sys.argv[2]
filter_type = sys.argv[3]

# Process the VCF files with the specified filter type (normalize, large, or small)
process_vcf(input_vcf_1, input_vcf_2, filter_type)

