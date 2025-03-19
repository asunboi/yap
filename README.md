# Links
[https://github.com/DingWB/cemba_data]  
[https://lh3.github.io/2017/11/13/which-human-reference-genome-to-use]  
[https://www.encodeproject.org/data-standards/reference-sequences/]  

# 03/18/25
Tried converting GTF files to BED files and then using intersect to see if we have any overlap over gene regions. 

module load bedops
gtf2bed < chrG.gtf > chrG.bed
bedtools intersect -a EckerRelaxedAligned.out.bam -b ../chrG.bed > intersect.bam
samtools view intersect.bam | grep Foxg1 | less
samtools view intersect.bam | grep Dnmt3a | less

gtf2bed < mm10_no_alt_ENCODE_chrL_chrG.gtf > mm10_no_alt_ENCODE_chrL_chrG.bed
mv mm10_no_alt_ENCODE_chrL_chrG.bed ~/jin_lab/yap/pipeline0_troubleshoot/
bedtools intersect -a EckerRelaxedAligned.out.bam -b ../mm10_no_alt_ENCODE_chrL_
samtools view full_intersect.bam | grep Foxg1 | less

zcat S_5_A24-Dnmt3ag2-R1.fq.gz | less
samtools view EckerRelaxedAligned.out.bam | grep lh00134:653:22MKYCLT4:3:1141:9664:4685 | less


# 03/17/25
@lh00134:653:22MKYCLT4:3:1226:40536:24919 1:N:0:GCAGATAATC+CGCTGTAGGA
TCACACATCAACTCAGAGTACCAAGTTGATAACGGACTAGCCTTATTTTAACTTGCTATTTCTAGCTCTAAAACTCACGCTCAGTCTGGGCCCCCACCAGATCGGAAGAGCACACGTCTGAACTCCAGTCACGCAGATAATCATCTG

samtools view EckerAligned.out.bam | grep AGCGCGTTGTAGCTGAACGG | less
samtools view EckerAligned.out.bam | grep GAGTTACAACGGGACCACGT | less
samtools view EckerAligned.out.bam | grep GGTAGAACTCAAAGAAGAGG | less
samtools view EckerAligned.out.bam | grep GCGGAGTGAACCCCAACCTG | less
samtools view EckerAligned.out.bam | grep GCTAGAAACCTAAAAATCTA | less
samtools view EckerAligned.out.bam | grep GGGCGATTGGAAAACACACA | less
samtools view EckerAligned.out.bam | grep CCGTTCAGCTACAACGCGCT | less
samtools view EckerAligned.out.bam | grep ACGTGGTCCCGTTGTAACTC | less
samtools view EckerAligned.out.bam | grep CCTCTTCTTTGAGTTCTACC | less
samtools view EckerAligned.out.bam | grep CAGGTTGGGGTTCACTCCGC | less
samtools view EckerAligned.out.bam | grep TAGATTTTTAGGTTTCTAGC | less
samtools view EckerAligned.out.bam | grep TGTGTGTTTTCCAATCGCCC | less

Tried:
cutadapt for well A23
alignment with star
looking at unaligned files (partial scaffold present, but a lot of the 5' and 3' sequences are just jumbled mouse dna (blasted))  
less stringent cutadapt (-m 1), instead of the adapter trimming + 10bp removal that ecker lab does  


# 03/16/25
cutadapt -Z -e 0.01 --no-indels -g file:/gpfs/home/asun/miniforge3/envs/yap/lib/python3.8/site-packages/cemba_data/files/random_index_v2/random_index_v2.fa -o /gpfs/home/asun/jin_lab/yap/pipeline2_yap/yap_demultiplex/S_5-1-D15/lanes/S_5-1-D15-L003-{name}-R1.fq.gz -p /gpfs/home/asun/jin_lab/yap/pipeline2_yap/yap_demultiplex/S_5-1-D15/lanes/S_5-1-D15-L003-{name}-R2.fq.gz /gpfs/home/asun/jin_lab/yap/pipeline2_yap/yap_demultiplex/S_5-1-D15/raw/S_5-1-D15+L003+R1.fq.gz /gpfs/home/asun/jin_lab/yap/pipeline2_yap/yap_demultiplex/S_5-1-D15/raw/S_5-1-D15+L003+R2.fq.gz > /gpfs/home/asun/jin_lab/yap/pipeline2_yap/yap_demultiplex/S_5-1-D15/lanes/S_5-1-D15-L003.demultiplex.stats.txt

made pipeline0_troubleshoot
made cutadapt scripts for both primer processing and then for removal of adapters and other sequences, and then also for reads that are too short, etc. 
STAR for RNA only uses R1; check snakefile of the TotalRNA files in yap or yap_chrG. 

4821562 reads; of these:
  4821562 (100.00%) were unpaired; of these:
    4821268 (99.99%) aligned 0 times
    95 (0.00%) aligned exactly 1 time
    199 (0.00%) aligned >1 times
0.01% overall alignment rate

lh00134:653:22MKYCLT4:3:1496:6331:14942

 1188  2025-03-16 23:02:40 bowtie2-build scaffold.fa .
 1189  2025-03-16 23:02:43 ls
 1190  2025-03-16 23:02:53 ls -lh
 1191  2025-03-16 23:03:09 ls -la
 1192  2025-03-16 23:03:19 bowtie2-build scaffold.fa scaffold
 1193  2025-03-16 23:03:58 ls
 1194  2025-03-16 23:05:31 bowtie2 -x scaffold -U S_5_1-R1.fq.gz -S S_5-R1.sam
 1195  2025-03-16 23:06:21 ls
 1196  2025-03-16 23:06:46 bowtie2 -x scaffold -U S_5_1-R1.fq.gz -S S_5-R1.sam -p 16 >bowtie.txt
 1197  2025-03-16 23:08:36 ls
 1198  2025-03-16 23:08:49 samtools view -F 4 S_5-R1.sam > mapped_reads.sam
 1199  2025-03-16 23:08:57 less mapped_reads.sam
 1200  2025-03-16 23:13:40 gunzip S_5_1-R1.fq.gz
 1201  2025-03-16 23:14:18 grep lh00134:653:22MKYCLT4:3:1141:50438:26068 S_5_1-R1.fq
 1202  2025-03-16 23:14:47 grep -A 4 lh00134:653:22MKYCLT4:3:1141:50438:26068 S_5_1-R1.fq
 1203  2025-03-16 23:15:58 grep chrG TotalRNAAligned.out.bam
 1204  2025-03-16 23:16:05 grep chr1 TotalRNAAligned.out.bam
 1205  2025-03-16 23:16:17 samtools view TotalRNAAligned.out.bam | head
 1206  2025-03-16 23:16:29 samtools view TotalRNAAligned.out.bam | grep chrG | less
 1207  2025-03-16 23:21:48 samtools view TotalRNAAligned.out.bam | grep chrG | grep gttttag
 1208  2025-03-16 23:22:25 samtools view TotalRNAAligned.out.bam | grep chrG | grep aggctagt | less
 1209  2025-03-16 23:22:45 samtools view TotalRNAAligned.out.bam | grep chrG | grep GTTTT | less
 1210  2025-03-16 23:27:37 samtools view TotalRNAAligned.out.bam | grep chrG | grep AGCGCGTTGT | less
 1211  2025-03-16 23:30:03 samtools view TotalRNAAligned.out.bam | grep chrG | grep GTTTT | less
 1212  2025-03-16 23:32:01 history

# 03/15/25
chrG mapping still isn't very good; I want to ask wubin how he generated the graphics for the specific guideRNA assignment. Would be easier to ask than to have to learn it myself. 

I think it's fair to demultiplex strict to cell A1 and evaluate what kind of sequences we see. 

TotalRNAAligned.out.bam is the original file

TotalRNAAligned.filtered.bam
@PG	ID:samtools	PN:samtools	PP:STAR	VN:1.21	CL:samtools sort -@ 10 -m 2G rna_bam/TotalRNAAligned.out.bam
@PG	ID:samtools.1	PN:samtools	PP:samtools	VN:1.21	CL:samtools view -bh -q 10 -o rna_bam/TotalRNAAligned.filtered.bam -

mct_star_bam_filter.py in cemba_data is what determines whether a read is methylated or not; I think the main thing is actually the first step to determine if TotalRNAAligned.out.bam is throwing away reads. 

# 03/14/25
Working on how to interpret the YAP output; also building the custom chrG.  
Judging by the way that Wubin and Bang-An were able to visualize the guide alignment on plates, I assume that ALLCools is able to implement this based on the alignment to the chrG guide rna sequence.  
Couldn't find any scaffold sequence in the dna / RNA bam files.  
Built chrG with sequences provided by Cassie; built GTF based on the location in the fa file. Added scaffolding behind each g1/g2.  
Reran reference building with pipeline1_chrG_references.  
Reran pipeline with pipeline2_yap_chrG.  
Single cell transcriptomics; so of course there's a barcode to demultiplex which reads belong to which cells. 384 random primer is the barcode; there are 384 wells for 384 cells. (duh)  
Xin expects the barcode to be present in 0.5 - 1% of all reads, so since I downsampled to 1% it's also possible i've somehow missed EVERY single read with grna + scaffold. When the downsampled one finishes running, I will do the full sample. 
If you look at the rna STAR output in the yap_demultiplex libraries, you still see relatively high (too short) sequences. Looking at the output stats for the oirignal run, we see that there is a high number of read pairs in lanes 1-8, but almost 0 RNA mapping when we should expect more RNA mapping than that of the other lanes. 

# 03/13/25
Arbitrarily renamed input fastq files from S_5_CKDL250004755-1A_22MKYCLT4_L3_1.sub.fq -> TEST-S_5-1-A1_ii1_L003_R1_ii2.fq  
I'm thinking that if YAP demultiplexes into the corresponding 384 RP anyways, it's good to just give it the novogene fail as input.  
Gzipped R1/R2 for input into YAP.  

Changed star_genomeGenerate.sbatch.sh to have --sjdbOverhang 100 because yap mapping has its own star alignment rule  

EXITING because of fatal PARAMETERS error: present --sjdbOverhang=100 is not equal to the value at the genome generation step =149
SOLUTION: 

Mar 13 12:30:18 ...... FATAL ERROR, exiting
[Thu Mar 13 12:30:18 2025]
Finished job 491.
9 of 635 steps (1%) done
Removing temporary output bam/S_5-5-A1-J21-R2.trimmed_bismark_bt2.filter.bam.
[Thu Mar 13 12:30:18 2025]

Traceback (most recent call last):
  File "/gpfs/home/asun/miniforge3/envs/yap/bin/allcools", line 8, in <module>
    sys.exit(main())
  File "/gpfs/home/asun/miniforge3/envs/yap/lib/python3.8/site-packages/ALLCools/__main__.py", line 838, in main
    func(**args_vars)
  File "/gpfs/home/asun/miniforge3/envs/yap/lib/python3.8/site-packages/ALLCools/_bam_to_allc.py", line 405, in bam_to_allc
    raise FileNotFoundError("Reference fasta not indexed. Use samtools faidx to index it and run again.")
FileNotFoundError: Reference fasta not indexed. Use samtools faidx to index it and run again.

squeue -u $USER -p shared -o "%A" | tail -n +2

#SBATCH -o /gpfs/home/asun/jin_lab/yap/pipeline2_yap/yap_demultiplex/snakemake/sbatch/yap_demultiplex_sbatch/yap_demultiplex_0.o%j       # Name of stdout output file
#SBATCH -e /gpfs/home/asun/jin_lab/yap/pipeline2_yap/yap_demultiplex/snakemake/sbatch/yap_demultiplex_sbatch/yap_demultiplex_0.e%j       # Name of stderr error file

Reran because sjdb overhang
reran because genome not indexed

For all the successful jobs
The minimum job elapsed: 0 days 00:00:13
The average job elapsed: 0 days 00:00:22
The maximum job elapsed: 0 days 00:00:30
6 / 18 succeeded


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

Talked with Ecker Lab, Wubin and Mojar. Wubin built a scaffold incorporated genome and added GTF annotation to it?

  File "/gpfs/home/asun/miniforge3/envs/yap/lib/python3.8/site-packages/cemba_data/demultiplex/fastq_dataframe.py", line 60, in _parse_v2_fastq_path
    assert lane in {'L001', 'L002', 'L003', 'L004','L005','L006','L007','L008'}
AssertionError

Lane has to be L003, rerunning demultiplex.
Read has to be actually R1 instead of just 1, etc. Rerunning demultiplex.

demultiplex/*s

holy moly the pipeline is so strict it's nuts; input files to yap demultiplex must be gzipped. I'm actually not sure if we even need to do cutadapt before yap demultiplex, mostly because it will do cutadapt on the file anyways; I think it's mainly a QC thing. I'm not sure our input primer_name matters; maybe we can even feed in the whole downsampled file.

from the snakefile:  
here we only use R1 SE for RNA,
R2 SE or R1R2 PE is worse than R1 actually, due to R2's low quality
And we map all cells together, so the genome is only load once

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
