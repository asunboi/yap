#!/bin/sh

# read 1 ecker trimming 
cutadapt -j 16 -u 6 all_rna_r1.fq | \
cutadapt \
    -a R1Adapter=AGATCGGAAGAGCACACGTCTGAAC \
    -a TSO=AAGCAGTGGTATCAACGCAGAGTGAATGG \
    -a N6=AAGCAGTGGTATCAACGCAGAGTAC \
    -a TSO_rc=CCATTCACTCTGCGTTGATACCACTGCTT \
    -a N6_rc=GTACTCTGCGTTGATACCACTGCTT \
    -a 3PpolyT=TTTTTTTTTTTTTTTX \
    -g 5PpolyT=XTTTTTTTTTTTTTTT \
    -a 3PpolyA=AAAAAAAAAAAAAAAX \
    -g 5PpolyA=XAAAAAAAAAAAAAAA \
    -a polyTLong=TTTTTTTTTTTTTTTTTTTTTTTTTTTTTT \
    -a polyALong=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA \
    -a ISPCR_F=AAGCAGTGGTATCAACGCAGAGT \
    -a ISPCR_R=ACTCTGCGTTGATACCACTGCTT \
    - \
    2> all_rna_r1.stats | \
cutadapt \
    --report=minimal \
    -O 6 \
    -q 20 \
    -u 10 \
    -u -10 \
    -m 30 \
    -o all_rna_r1.trimmed.fq \
    - \
    >> all_rna_r1.trimmed.stats

# read 2 ecker trimming
cutadapt \
    -a R1Adapter=AGATCGGAAGAGCGTCGTGTAGGGA \
    -a TSO=AAGCAGTGGTATCAACGCAGAGTGAATGG \
    -a N6=AAGCAGTGGTATCAACGCAGAGTAC \
    -a TSO_rc=CCATTCACTCTGCGTTGATACCACTGCTT \
    -a N6_rc=GTACTCTGCGTTGATACCACTGCTT \
    -a 3PpolyT=TTTTTTTTTTTTTTTX \
    -g 5PpolyT=XTTTTTTTTTTTTTTT \
    -a 3PpolyA=AAAAAAAAAAAAAAAX \
    -g 5PpolyA=XAAAAAAAAAAAAAAA \
    -a polyTLong=TTTTTTTTTTTTTTTTTTTTTTTTTTTTTT \
    -a polyALong=AAAAAAAAAAAAAAAAAAAAAAAAAAAAAA \
    -a ISPCR_F=AAGCAGTGGTATCAACGCAGAGT \
    -a ISPCR_R=ACTCTGCGTTGATACCACTGCTT \
    all_rna_r2.fq \
    2> all_rna_r2.stats | \
cutadapt \
    --report=minimal \
    -O 6 \
    -q 20 \
    -u 10 \
    -u -10 \
    -m 30 \
    -o all_rna_r2.trimmed.fq \
    - \
    >> all_rna_r2.trimmed.stats
