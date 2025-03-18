#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64000
#SBATCH --time=72:00:00
#SBATCH --partition=highmem

STAR --runThreadN 16 \
--runMode genomeGenerate \
--genomeDir /gpfs/group/jin/ref_genomes/asun_mm10_w_chrG/star/ \
--genomeFastaFiles /gpfs/group/jin/ref_genomes/asun_mm10_w_chrG/mm10_no_alt_ENCODE_chrL_chrG.fa \
--sjdbGTFfile /gpfs/group/jin/ref_genomes/asun_mm10_w_chrG/mm10_no_alt_ENCODE_chrL_chrG.gtf