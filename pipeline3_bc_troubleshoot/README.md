S10_TotalAlignedChrG.rna_reads.sam generated with get_chrG_reads.sh with -F 0.5
S10_TotalAlignedChrG.nofilter.rna_reads.sam generated with get_chrG_reads.sh with no -F parameter.

S10_TotalAlignedChrG.nofilter.rna_reads.readnames.txt generated with `cut -f1 S10_TotalAlignedChrG.nofilter.rna_reads.sam | sort -u > S10_TotalAlignedChrG.nofilter.rna_reads.names`

local_has_well.readnames.txt generated from pipeline0_bt2_local_alignment

unique_to_local.txt generated with `comm -23 <(sort local_has_well.readnames.txt) <(sort S10_TotalAlignedChrG.nofilter.rna_reads.readnames.txt) > unique_to_local.txt`

