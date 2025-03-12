# Links
[https://github.com/DingWB/cemba_data]  
[https://lh3.github.io/2017/11/13/which-human-reference-genome-to-use]  
[https://www.encodeproject.org/data-standards/reference-sequences/]  

# 03/12/25
https://www.encodeproject.org/files/ENCFF708YIO/@@download/ENCFF708YIO.tar.gz
Got chromosome sizes through faSizes for custom reference. Wrote bash script for yap mapping config.  

Set up yap demultiplex, but Cassie did not do bcl2fastq the same way Ecker lab did; novogene just gives 2 fastq files with no library info.  

Tried to run demultiplex but library names must be formatted a specific way according to /gpfs/home/asun/miniforge3/envs/yap/lib/python3.8/site-packages/cemba_data/demultiplex/fastq_dataframe.py

UID pattern of V2 {sample_id_prefix}-{plate}-{multiplex_group}-{barcode_name}  
FASTQ name pattern of V2:  
{sample_id_prefix}-{plate}-{multiplex_group}-{barcode_name}_{internal_info}_{lane}_{read_type}_{internal_info}.fastq.gz  

Making some assumptions; Position in 384RP xlsx is the same thing as primer_name/barcode_name in YAP.   

Have to demultiplex the sample somehow; hopefully the random primer is at the start of the reads in our fq file.  

I'm goated; it's there. Wrote cutadapt script for demultiplexing the downsampled input. Could theoretically request novogene for the bcl files and do Ecker lab method of using yap's samplesheet for bcl2fastq.  

I need plate, multiplex_group, primer_name, lane, read_type.  

Plate is just our sample name  
Multiplex group is 1  
Primer_name is in the xlsx/fasta file  
Lane is 3  
Read_type is R1/R2  

# 03/11/25
Working with Cassie's data  
Tried to run star alignment but reads were unmapped (too short) (99%)  
Turns out she was using the SE pipeline -> changed to PE  
Still mapping ~23% unique reads, ~70% unmapped (too short)  
Illumina universal adapter sequence still present in reads  
No standardized reference genome in our lab yet  

reference [https://www.encodeproject.org/files/mm10_no_alt_analysis_set_ENCODE/@@download/mm10_no_alt_analysis_set_ENCODE.fasta.gz]  
lambda genome [https://www.encodeproject.org/files/lambda.fa/@@downloadlambda.fa.fasta.gz] [https://www.ncbi.nlm.nih.gov/nuccore/215104]  
bismark  
GTF
STAR  


cat mm10_no_alt_analysis_set_ENCODE.fasta lambda.fa.fasta > mm10_no_alt_analysis_ENCODE_with_chrL.fasta  
fold mm10_no_alt_analysis_ENCODE_with_chrL.fasta > mm10_no_alt_analysis_ENCODE_with_chrL_fold.fasta  
mv mm10_no_alt_analysis_ENCODE_with_chrL_fold.fasta mm10_no_alt_analysis_ENCODE_with_chrL.fa  

made a directory bismark in the ref_genomes/asun/ folder, ran bismark.sbatch in /src/ to index it  

lowkey im getting fucked up by this reference file generation but i got it, only took like 5 hours
