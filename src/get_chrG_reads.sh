#!/bin/bash
for d in /gpfs/home/asun/jin_lab/yap/pipeline2_yap_s10/yap_demultiplex/S_10*/rna_bam/; do
    echo $d
    cd $d
    bedtools intersect -F 0.5 -a TotalRNAAligned.rna_reads.bam -b /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_chrG/build/chrG.bed > intersect.bam
    samtools view --no-header intersect.bam >> /gpfs/home/asun/jin_lab/yap/pipeline3_bc_troubleshoot/S10_TotalAlignedChrG.rna_reads.sam
    rm intersect.bam
done