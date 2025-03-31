#!/bin/bash

for d in /gpfs/home/asun/jin_lab/yap/pipeline2_yap_iseq0328_2/demultiplex/iseq0328*/rna_bam/; do
    echo $d
    cd $d
    bedtools intersect -a TotalRNAAligned.rna_reads.bam -b /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_chrG/build/chrG.bed > intersect.bam
    samtools view --no-header intersect.bam >> /gpfs/home/asun/jin_lab/yap/pipeline2_yap_iseq0328_2/TotalAlignedChrG.rna_reads.sam
    rm intersect.bam
done