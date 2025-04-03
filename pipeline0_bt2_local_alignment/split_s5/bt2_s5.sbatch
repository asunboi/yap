#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=72000
#SBATCH --time=12:00:00
#SBATCH --partition=highmem
#SBATCH -o /gpfs/home/asun/jin_lab/yap/logs/%x.o%j       # Name of stdout output file
#SBATCH -e /gpfs/home/asun/jin_lab/yap/logs/%x.e%j 

# bowtie2-build mm10_no_alt_ENCODE_chrL_chrG.fa mm10_no_alt_ENCODE_chrL_chrG

bowtie2 \
-x /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_split_chrG/mm10_no_alt_ENCODE_chrL_chrG \
--local \
-1 /gpfs/home/asun/jin_lab/yap/raw_data/S_5/TEST-S_5-1-A1_ii1_L003_R1_ii2.fq.gz \
-2 /gpfs/home/asun/jin_lab/yap/raw_data/S_5/TEST-S_5-1-A1_ii1_L003_R2_ii2.fq.gz \
-p 16 \
-S local.sam

samtools view -Sb local.sam -o local.bam
bedtools intersect -F 0.5 -a local.bam -b /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_split_chrG/build/chrG.bed > intersect.bam

#bedtools intersect -F 0.5 -a TotalAlignedChrG.rna_reads.sam -b /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_chrG/build/chrG.bed > intersect_filter.sam
