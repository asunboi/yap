#!/bin/bash

bowtie2-build mm10_no_alt_ENCODE_chrL_chrG.fa mm10_no_alt_ENCODE_chrL_chrG

bowtie2 \
-x /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_chrG/mm10_no_alt_ENCODE_chrL_chrG \
--local \
-1 /gpfs/home/asun/jin_lab/yap/raw_data/0328_iseq/TEST-iseq0328-1-A1_ii1_L001_R1_ii2.fq.gz \
-2 /gpfs/home/asun/jin_lab/yap/raw_data/0328_iseq/TEST-iseq0328-1-A1_ii1_L001_R2_ii2.fq.gz \
-p 16 \
-S local.sam

samtools view -b local.sam -o local.bam
bedtools intersect -a local.bam -b /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_chrG/build/chrG.bed > intersect.bam

