#!/bin/bash


#awk 'BEGIN {FS=">"} {if(NR>1) {seq = $2; gsub(/\n/, "", seq); sequences[seq] = 1}} END {}' grna_reads.fa

#awk 'BEGIN {FS=">"} {if(NR>1) {header = $1; seq = $2; gsub(/\n/, "", seq); if(seq in sequences) print header}}' /gpfs/home/asun/jin_lab/yap/raw_data/384RPIndexes.fasta

awk 'BEGIN {FS=">"} 
    NR == FNR { 
        if (NR > 1) { 
            seq = $2; gsub(/\n/, "", seq); sequences[seq] = 1 
        } 
        next 
    } 
    NR > FNR { 
        if (NR % 2 == 0) {
            seq = $0; gsub(/\n/, "", seq); 
            if (seq in sequences) { 
                header = $(NR-1); 
                print ">" header 
            }
        } 
    }' grna_reads.fa /gpfs/home/asun/jin_lab/yap/raw_data/384RPIndexes.fasta