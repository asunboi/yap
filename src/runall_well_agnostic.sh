#!/bin/bash

rp_primer_name=$1
rp_primer_sequence=$(grep -A 1 $rp_primer_name /gpfs/home/asun/cemba_data/files/random_index_v2/random_index_v2.fa | tail -n 1)

mkdir $1
outputdir=$1

demultiplex_file_R1="${outputdir}/S_5_${rp_primer_name}-R1.fq.gz"
demultiplex_file_R2="${outputdir}/S_5_${rp_primer_name}-R2.fq.gz"

input_file_R1="/gpfs/home/asun/jin_lab/yap/raw_data/novogene/S_5/S_5_CKDL250004755-1A_22MKYCLT4_L3_1.fq.gz"
input_file_R2="/gpfs/home/asun/jin_lab/yap/raw_data/novogene/S_5/S_5_CKDL250004755-1A_22MKYCLT4_L3_2.fq.gz"

demultiplex_stats_file="./${outputdir}/S_5_${rp_primer_name}.demultiplex.stats.txt"

cutadapt -j 16 \
-Z \
-e 0.01 \
--no-indels \
-g ${rp_primer_sequence} \
--discard-untrimmed \
-o ${demultiplex_file_R1} \
-p ${demultiplex_file_R2} \
${input_file_R1} \
${input_file_R2} > $demultiplex_stats_file

cd $outputdir
workingdir=$(pwd)

cutadapt -j 16 \
-m 1 \
-o S_5_${rp_primer_name}-R1.minimal.fq.gz \
S_5_${rp_primer_name}-R1.fq.gz

cutadapt -j 16 \
-g Foxg1g1=AGCGCGTTGTAGCTGAACGG \
-g Foxg1g2=GAGTTACAACGGGACCACGT \
-g Dnmt3ag1=GGTAGAACTCAAAGAAGAGG \
-g Dnmt3ag2=GCGGAGTGAACCCCAACCTG \
-g Stg1=GCTAGAAACCTAAAAATCTA \
-g Stg2=GGGCGATTGGAAAACACACA \
-O 10 \
--action=lowercase \
--discard-untrimmed \
-o S_5_${rp_primer_name}-{name}-R1.fq.gz \
S_5_${rp_primer_name}-R1.minimal.fq.gz

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
--outFileNamePrefix $workingdir/Ecker \
--readFilesIn $workingdir/S_5_${rp_primer_name}-R1.minimal.fq.gz \
--outReadsUnmapped Fastx \
--readFilesCommand gzip \
-cd


