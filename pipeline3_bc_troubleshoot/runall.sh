#!/bin/bash

cut -f1 all_rna_aligned.R1.sam >> all_rna_readnames.txt
wc -l all_rna_readnames.txt
# 38833241 all_rna_readnames.txt

sort -u all_rna_readnames.txt | wc -l
# 38833241

module load seqtk
seqtk subseq /gpfs/home/asun/jin_lab/yap/raw_data/S_10/S_10_CKDL250004755-1A_22MKYCLT4_L3_1.fq.gz all_rna_readnames.txt > all_rna_r1.fq
seqtk subseq /gpfs/home/asun/jin_lab/yap/raw_data/S_10/S_10_CKDL250004755-1A_22MKYCLT4_L3_2.fq.gz all_rna_readnames.txt > all_rna_r2.fq

sbatch star_all_rna_r1.sbatch.sh
sbatch star_all_rna_r2.sbatch.sh