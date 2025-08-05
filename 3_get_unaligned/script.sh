#!/bin/bash

input_dir=/gpfs/home/asun/jin_lab/yap/2_yap_s10/yap_demultiplex/S_10*
raw_r1=/gpfs/home/asun/jin_lab/yap/raw_data/S_10/S_10_CKDL250004755-1A_22MKYCLT4_L3_1.fq.gz
raw_r2=/gpfs/home/asun/jin_lab/yap/raw_data/S_10/S_10_CKDL250004755-1A_22MKYCLT4_L3_2.fq.gz
output_dir=$(pwd)


for d in $input_dir/rna_bam/; do
    cd $d
    echo $d
    echo "samtools view --no-header TotalRNAAligned.rna_reads.bam >> $output_dir/all_rna_aligned.sam"
done

for d in $input_dir/bam/; do
    cd $d
    echo $d
    for f in *.dna_reads.bam; do
        echo "samtools view --no-header \"$f\" >> $output_dir/all_dna_aligned.sam"
    done
done

cd $output_dir
samtools view all_rna_aligned.sam | cut -f1 | sort -u > rna_readnames.txt
samtools view all_dna_aligned.sam | cut -f1 | sort -u > dna_readnames.txt
sort -u rna_readnames.txt dna_readnames.txt > aligned_readnames.txt

zcat $raw_r1 | paste - - - - | cut -f1 | sed 's/^@//' | sort -u > all_readnames.txt

comm -23 all_readnames.txt aligned_readnames.txt > unaligned_readnames.txt

# Extract unaligned reads using seqtk
seqtk subseq $raw_r1 unaligned_readnames.txt > unaligned_r1.fq
seqtk subseq $raw_r2 unaligned_readnames.txt > unaligned_r2.fq

