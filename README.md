# Links
[https://github.com/DingWB/cemba_data]  
[https://lh3.github.io/2017/11/13/which-human-reference-genome-to-use]  
[https://www.encodeproject.org/data-standards/reference-sequences/]  

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
