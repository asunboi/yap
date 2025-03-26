#!/bin/bash

"""
samtools view all_rna_r1Aligned.out.bam | grep chrG | grep GTTTTA >> r1_chrG.sam
samtools view all_rna_r1Aligned.out.bam | grep chrG | grep GTTTAAG >> r1_chrG.sam

cut -f1 r1_chrG.sam | sort -u > r1_chrG.names

samtools view all_rna_r2Aligned.out.bam | grep chrG | grep GTTTTA >> r2_chrG.sam
samtools view all_rna_r2Aligned.out.bam | grep chrG | grep GTTTAAG >> r2_chrG.sam

cut -f1 r2_chrG.sam | sort -u > r2_chrG.names

comm -12 <(sort r1_chrG.names) <(sort r2_chrG.names) > overlapping_names.txt
"""

comm -23 <(sort r2_chrG.names) <(sort r1_chrG.names) > unique_to_r2.txt