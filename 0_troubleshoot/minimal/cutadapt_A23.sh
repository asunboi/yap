#!/bin/sh

"""
cutadapt -j 16 -Z -e 0.01 --no-indels -g ACGATCAG --discard-untrimmed -o /gpfs/home/asun/jin_lab/yap/pipeline0_troubleshoot/S_5_A23-R1.fq.gz -p /gpfs/home/asun/jin_lab/yap/pipeline0_troubleshoot/S_5_A23-R2.fq.gz /gpfs/home/asun/jin_lab/yap/raw_data/novogene/S_5/S_5_CKDL250004755-1A_22MKYCLT4_L3_1.fq.gz /gpfs/home/asun/jin_lab/yap/raw_data/novogene/S_5/S_5_CKDL250004755-1A_22MKYCLT4_L3_2.fq.gz > /gpfs/home/asun/jin_lab/yap/pipeline0_troubleshoot/S_5_A23.demultiplex.stats.txt
"""

"""
cutadapt -j 16 -a R1Adapter=AGATCGGAAGAGCACACGTCTGAAC -a TSO=AAGCAGTGGTATCAACGCAGAGTGAATGG -a N6=AAGCAGTGGTATCAACGCAGAGTAC -a TSO_rc=CCATTCACTCTGCGTTGATACCACTGCTT -a N6_rc=GTACTCTGCGTTGATACCACTGCTT -a 3PpolyT=TTTTTTTTTTTTTTTX -g 5PpolyT=XTTTTTTTTTTTTTTT -a 3PpolyA=AAAAAAAAAAAAAAAX -g 5PpolyA=XAAAAAAAAAAAAAAA -a polyTLong=TTTTTTTTTTTTTTTTTTTTTTTTTTTTTT -a polyALong=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA -a ISPCR_F=AAGCAGTGGTATCAACGCAGAGT -a ISPCR_R=ACTCTGCGTTGATACCACTGCTT S_5_A23-R1.fq.gz 2> S_5_A23-R1.stats | cutadapt --report=minimal -O 6 -q 20 -u 10 -u -10 -m 30 -o S_5_A23-R1.trimmed.fq.gz - >> S_5_A23-R1.trimmed.stats
"""

cutadapt -j 16 -m 1 -o S_5_A23-R1.minimal.fq.gz S_5_A23-R1.fq.gz
