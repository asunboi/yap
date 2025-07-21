#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=40000
#SBATCH --time=12:00:00
#SBATCH --partition=highmem
#SBATCH -o /gpfs/home/asun/jin_lab/yap/logs/star.o%j       # Name of stdout output file
#SBATCH -e /gpfs/home/asun/jin_lab/yap/logs/star.e%j 

STAR --runThreadN 16 \
--genomeDir /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_chrG/star \
--quantMode TranscriptomeSAM GeneCounts \
--genomeLoad NoSharedMemory \
--outFileNamePrefix /gpfs/home/asun/jin_lab/yap/pipeline0_troubleshoot/minimal/TotalRNA \
--readFilesIn /gpfs/home/asun/jin_lab/yap/pipeline0_troubleshoot/minimal/S_5_A23-R1.minimal.fq.gz \
--outReadsUnmapped Fastx \
--readFilesCommand gzip \
-cd

STAR --runThreadN 16 \
--genomeDir /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_chrG/star \
--alignEndsType Local \
--genomeLoad NoSharedMemory \
--outSAMstrandField intronMotif \
--outSAMtype BAM Unsorted \
--outSAMattributes NH HI AS NM MD \
--sjdbOverhang 100 \
--outFilterType BySJout \
--outFilterMultimapNmax 20 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--outFilterMismatchNmax 999 \
--outFilterMismatchNoverLmax 0.04 \
--alignIntronMin 20 \
--alignIntronMax 1000000 \
--alignMatesGapMax 1000000 \
--outFileNamePrefix /gpfs/home/asun/jin_lab/yap/pipeline0_troubleshoot/Ecker \
--readFilesIn /gpfs/home/asun/jin_lab/yap/pipeline0_troubleshoot/minimal/S_5_A23-R1.minimal.fq.gz \
--outReadsUnmapped Fastx \
--readFilesCommand gzip \
-cd