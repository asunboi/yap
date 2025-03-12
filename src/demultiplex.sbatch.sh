#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=40000
#SBATCH --time=12:00:00
#SBATCH --partition=highmem

yap demultiplex \
--fastq_pattern "/gpfs/home/asun/jin_lab/yap/raw_data/demultiplex/*.fq" \
-o /gpfs/home/asun/jin_lab/yap/pipeline2_yap/yap_demultiplex \
-j 16 \
--aligner bismark \
--config_path mct_config.ini
