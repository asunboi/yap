#!/bin/bash

for d in S_10*/rna_bam/; do
    cd $d
    samtools view --no-header TotalRNAAligned.rna_reads.bam >> ../../all_rna_aligned.sam
    cd ../../
done