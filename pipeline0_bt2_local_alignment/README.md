Regular refers to using mm10_no_alt_ENCODE_chrL_chrG.fa with the continuous decoy chromosome. 

Spacer refers to using mm10_no_alt_ENCODE_chrL_chrG.fa with 10bp X nucleotide in the decoy chromosome; decoy chrG is still one continuous chromosome. Using X as a base leads bowtie to align it as intronic sequence, meaning the MD string will have a corresponding length I, so we can filter out reads that are protospacer aligned but in the wrong configuration by filtering for I.

Split refers to using mm10_no_alt_ENCODE_chrL_chrG.fa with split decoy sequences; each of the protospacer + scaffold is its own decoy. This seems to work best for local alignment, as there is no consideration for splice junction annotation and no minimum length overlap for the read to align to the decoy.

In each of the folders there will be a variant of a script named bt2_X.sbatch, submitted by `sbatch bt2_X.sbatch`. The only thing necessary to change for personal use is -1 and -2 paths, where -1 is the forward read file and -2 is the reverse read file. 

Follow up analysis can be done with notebooks/processing.ipynb. 

readnames.txt contains the 112 unique reads that have grna detected.
readnames_no_null_wells.txt contains 96 reads that have grna and are assigned to a well.
