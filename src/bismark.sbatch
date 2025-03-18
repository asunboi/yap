#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=72000
#SBATCH --time=40:00:00
#SBATCH --partition=highmem

bismark_genome_preparation /gpfs/group/jin/ref_genomes/asun_mm10_w_chrG/
