#!/bin/sh

wd="/gpfs/home/asun/jin_lab/yap/raw_data"
sample_id_prefix="TEST"
plate="S_5"
multiplex_group="1"
lane="L003"

mate1_output="${sample_id_prefix}-${plate}-${multiplex_group}-{name}_ii1_${lane}_1_ii2.fq"
mate2_output="${sample_id_prefix}-${plate}-${multiplex_group}-{name}_ii1_${lane}_2_ii2.fq"

cutadapt \
-e 1 \
-g ^file:${wd}/384RPIndexes.fasta \
--action=lowercase \
-j 16 \
-o ${wd}/demultiplex/${mate1_output} \
-p ${wd}/demultiplex/${mate2_output} \
${wd}/S_5_CKDL250004755-1A_22MKYCLT4_L3_1.sub.fq \
${wd}/S_5_CKDL250004755-1A_22MKYCLT4_L3_2.sub.fq