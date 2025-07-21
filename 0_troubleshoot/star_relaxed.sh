#!/bin/bash

STAR --runThreadN 16 \
--genomeDir /gpfs/home/asun/jin_lab/yap/raw_data/ref_w_chrG/star \
--alignEndsType Local \
--genomeLoad NoSharedMemory \
--outSAMstrandField intronMotif \
--outSAMtype BAM Unsorted \
--outSAMattributes NH HI AS NM MD \
--sjdbOverhang 100 \
--outFilterScoreMinOverLread 0 \
--outFilterMatchNminOverLread 0 \
--outFilterMatchNmin 0 \
--outFileNamePrefix /gpfs/home/asun/jin_lab/yap/pipeline0_troubleshoot/A24/EckerRelaxed \
--readFilesIn /gpfs/home/asun/jin_lab/yap/pipeline0_troubleshoot/A24/S_5_A24-R1.minimal.fq.gz \
--outReadsUnmapped Fastx \
--readFilesCommand gzip \
-cd