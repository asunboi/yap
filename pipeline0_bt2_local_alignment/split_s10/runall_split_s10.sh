#!/bin/bash

#samtools view intersect.bam | cut -f1 | sort -u > readnames.txt

module load seqtk
seqtk subseq /gpfs/home/asun/jin_lab/yap/raw_data/S_10/S_10_CKDL250004755-1A_22MKYCLT4_L3_1.fq.gz readnames.txt > grna_r1.fq
seqtk subseq /gpfs/home/asun/jin_lab/yap/raw_data/S_10/S_10_CKDL250004755-1A_22MKYCLT4_L3_2.fq.gz readnames.txt > grna_r2.fq

