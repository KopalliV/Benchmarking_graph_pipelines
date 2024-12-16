import sys

for l in open(sys.argv[1]):

    l_arr=l.rstrip().split("\t")

    s=int(l_arr[1])

    e=int(l_arr[2])

    if(l_arr[3]=="insertion"):

        seq=l_arr[4].upper()

        if(len(set(seq)-set("ACGT")) > 0):

            continue

    if(s>0 and e>0 and e-s>0):

        print(l.rstrip())
