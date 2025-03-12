#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=40000
#SBATCH --time=12:00:00
#SBATCH --partition=highmem

## change parameters according to estimated time needed and suffix of fastq files

/gpfs/group/jin/software/STAR-2.7.9a/source/STAR \
    --genomeLoad LoadAndKeep \
    --genomeDir /gpfs/group/jin/ref_genomes/mm10_w_gRNA/Genome/ \
	--runThreadN=16 \
    --readFilesIn S_5_CKDL250004755-1A_22MKYCLT4_L3_1.sub.fq S_5_CKDL250004755-1A_22MKYCLT4_L3_2.sub.fq \
    --quantMode TranscriptomeSAM GeneCounts \
    --readFilesCommand cat \
    --outFileNamePrefix /gpfs/home/asun/outs_relaxed/S_5_CKDL250004755-1A_22MKYCLT4_L3 \
    --outFilterScoreMinOverLread 0 \
    --outFilterMatchNminOverLread 0 \
    --outFilterMatchNmin 0 \
    --outReadsUnmapped Fastx	

