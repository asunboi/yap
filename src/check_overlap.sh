#!/bin/bash

bedtools intersect -a TotalRNAAligned.rna_reads.bam -b chrG.bed > intersect.bam
samtools view TotalRNAAligned.rna_reads.bam | grep chrG > totalRNA_chrG.sam
samtools view intersect_genes.bam | cut -f1 | sort > gene_reads.txt
cut -f1 totalRNA_chrG.sam | sort > chrG_reads.txt
comm -23 gene_reads.txt chrG_reads.txt > uniq_gene.txt
comm -13 gene_reads.txt chrG_reads.txt > uniq_chrG.txt
grep -F -f uniq_chrG.txt totalRNA_chrG.sam > non_gene.sam