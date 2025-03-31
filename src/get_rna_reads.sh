#!/bin/bash

for d in /gpfs/home/asun/jin_lab/yap/pipeline2_yap_iseq0328/yap_demultiplex/iseq0328*/rna_bam/; do
    cd $d
    samtools view --no-header TotalRNAAligned.rna_reads.bam >> /gpfs/home/asun/jin_lab/yap/pipeline2_yap_iseq0328/all_rna_aligned.sam
done