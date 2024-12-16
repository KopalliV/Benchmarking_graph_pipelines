while read p; do
    grep -w -i $p file.2.noN.txt | cut -f 7,8,9,11 | awk '{$1=$1;$2=$2-1;$3=$3;$5=$4;$4="insertion";$6="0";print}' | sed -e "s/\r//g" | tr ' ' '\t' | grep "^Chr" > $p.ins
    grep -w -i $p file.1.2.txt | cut -f 6,7,8 |  awk '{$1=$1;$2=$2-1;$3=$3;$4="deletion";$5="None";$6="0";print}' | sed -e "s/\r//g" | tr ' ' '\t' | grep "^Chr" > $p.del
    python verify_bed.py $p.ins > $p.ins.ver
    python verify_bed.py $p.del > $p.del.ver
    cat $p.ins.ver $p.del.ver | sort -k 1,1 -k 2,2n > $p.vars.bed
done <list.txt
