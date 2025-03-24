#!/bin/bash

for d in S_10*/rna_bam/; do
    cd $d
    bedtools intersect -a TotalRNAAligned.rna_reads.bam -b /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_chrG/build/chrG.bed > intersect.bam
    samtools view --no-header intersect.bam >> ../../TotalAlignedChrG.rna_reads.sam
    cd ../../
done