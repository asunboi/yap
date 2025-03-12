#!/bin/sh

cutadapt -e 1 -g ^file:384RPIndexes.fasta --action=lowercase -j 16 -o demultiplex/trimmed-{name}.1.fastq -p demultiplex/trimmed-{name}.2.fastq S_5_CKDL250004755-1A_22MKYCLT4_L3_1.sub.fq S_5_CKDL250004755-1A_22MKYCLT4_L3_2.sub.fq