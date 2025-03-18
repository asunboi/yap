#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64000
#SBATCH --time=72:00:00
#SBATCH --partition=highmem

STAR --runThreadN 16 \
--runMode genomeGenerate \
--genomeDir /gpfs/group/jin/ref_genomes/asun/star/ \
--genomeFastaFiles /gpfs/group/jin/ref_genomes/asun/mm10_no_alt_analysis_ENCODE_with_chrL.fa \
--sjdbGTFfile /gpfs/group/jin/ref_genomes/asun/ENCFF871VGR.gtf