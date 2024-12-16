while read p; do
    VISOR HACk -g ../../Sbicolor_454_v3.0.1.chrs.fa -b $p.vars.bed -o genome.$p > HACk.$p.log
    python converter.py ../../Sbicolor_454_v3.0.1.chrs.fa $p.vars.bed $p.vars.vcf
    grep -v "^#" $p.vars.vcf | cut -f 8 | cut -f 1,3 -d ";" | tr ';' '\t' | sed 's/SVTYPE=//' | sed 's/SVLEN=//' > $p.check.len
    python converter3.py ../../Sbicolor_454_v3.0.1.chrs.fa $p.vars.bed $p.vars.insseq.vcf
done <list.txt
