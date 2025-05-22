# Links
[https://github.com/DingWB/cemba_data]  
[https://lh3.github.io/2017/11/13/which-human-reference-genome-to-use]  
[https://www.encodeproject.org/data-standards/reference-sequences/]  

# 05/22/25


# 05/19/25
[] look into modification of BT2 parameters for more lenient matching of reads
[] give false positive (reads that align to end of scaffold + start of grna) and false negative (reads that are discarded by STAR but picked up by BT2) examples to ecker lab bioinfo  
[] add gene name conversion to global_visualization.ipynb (eventually)

Ran visualization for STAR / global aligned reads again but with 0 as a clear well. Refactored global visualization into a global_visualization.ipynb.  

Checked differences between STAR and BT2  

STAR  
- align over L 66%  
- match over L 66%  
- map over L 4%  
- multimap 20  

BT2  
- ~30 bp of the read has to align given 150bp read length and local alignment score of 20 + 8 * ln(readlen)  
- highest scoring read is reported, this can change with parameter k to report k highest scoring reads  


# 05/15/25
Looking into why the results from Cassie's hand annotated well visualization were different from my current plot_on_plate visualization, especially given the fact that we ran the same code. The issue mainly lies in the fact that when I was iterating through processing.ipynb, the original dataframe did not account for the fact that while bowtie2 gives the full sequence, if the read is aligned in RC, the read given will also be RC. Therefore when I was originally using the first 8bp to check for well identity, it was using the wrong orientation for some reads. This was what was produced in local_align.tsv, and corrected in local_align_extra.tsv. The issue was that while we got more hits in local_align_extra.tsv, some of the reverse sequences in local_align.tsv just happened to map to wells and then their real forward read was mapped to a different well, but that was unaccounted for when Cassie manually annotated wells.

Created a local_visualization.ipynb notebook specificially for modular visualization of our gRNA.


# 05/14/25
[] Need to convert EMBL gene names to regular names for search purposes.

Made a folder for grna visualization in plate and the accompanying notebook. It looks like our results are still different from the ones in the ecker lab, so i'm wondering where the disparity is from? 

I checked any changes I made to the pipeline, but the changes to cemba_data/files/smk/bismark/mct.smk were only made after the iseq run, so the R, S5 and S10 plates are all using default mct settings.

Started off by joining TotalRNA.h5 with mapping summary and visualizing the STAR identified guide RNA. 
Since we are using the ENCODE reference genome, our genes are named using ensembl id and not gene symbol. Then, to make the dataframe more accessible there needs to be a mapping from ensembl id to gene name. 
This can be done with mygene, developed by the Wu & Su labs (surprising)! A couple of caveats, the ensembl id has to be processed to use a non-versioned gene ID, for example ENSMUSG00000118388 instead of ENSMUSG00000118388.1. There also seems to be a endpoint time limit, so I am not sure I can put the full gene list in for processing. The dataframe format as output is also better than the JSON for further parsing.
Cassie said that this is not an immediate need, so putting this on the backlog for now.
Focusing on local alignment visualization. Took the dataframe code from the tsv generation notebook and transformed it into a well x grna matrix. 
Originally pd.merge joined with inner merge, so only 28 wells were displayed. Changed to using merge on left, but then no wells showed any expression. Trying to figure this out; there is a distinct difference when visualizing the dataset with only 28 wells vs 384. 
Looking at the plot on plate code in /gpfs/home/asun/jin_lab/yap/cemba_data/mapping/stats/plot.py. 
Found out that the issue lies in the distplot_and_plate_view function, where vmin and vmax is derived from cutoff_vs_cell_remain. cutoff_vs_cell_remain has outlier removal, taking the 0.01 to 0.99 quantile. Since our grna matrix is so sparse, with only ~30 of wells containing grna out of 384, all our well values are considered outliers. 
Made a new function test_xlim to use only the plot_on_plate function call with vmin as 0 and vmax as the maximum amount of grna seen. 
Added a new column Total_grna to visualize all wells with non-zero grna expression.

# 04/10/25
Removing a couple of symlinks from the home directories.
cemba_data -> /gpfs/home/asun/miniforge3/envs/yap/lib/python3.8/site-packages/cemba_data/
demultiplex -> /gpfs/home/asun/miniforge3/envs/yap/lib/python3.8/site-packages/cemba_data/demultiplex

# 03/31/25
Running 0328 iseq through ecker lab pipeline.

pipeline2_yap_iseq0328
Pipeline 2 Yap iseq0328: running ecker lab pipeline on March 28 iSeq experiment, detected gRNA through grep based methods but no alignment through ecker pipeline.

Pipeline 2 Yap iseq0328 Run 2: Modified ecker lab trimming in cemba_data/files/smk/bismark/mct.smk to remove TSO trimming since some of our gRNA was downstream of the TSO trimming. Running ecker lab pipeline on March 28 iSeq experiment, detected gRNA through grep based methods but no alignment through ecker pipeline still.

# 03/27/25
Edited runall script for Cassie.

# 03/26/25
Yap Summary on R plate; RNA mapping quality across all wells looks way poorer than the amplified plates. No hits on Foxg1; Can look into alignment but I would predict that we get nothing. Less than 10% mapping.  

Trimmed and aligned R1/2 with ecker trimming standards, both reads mapping at >90% now. Extracted alignment to chrG, and then tested to see if R2 found grna that R1 missed. Only 1 extra read was identified, with a 4bp overlap with the protospacer (not very significant).  
Since this is the case, we will treat R1 as identifying the majority of gRNA sequences.  
Extracted raw R1/2 that aligned to protospacer sequences, send the file paths to cassie.  

# 03/25/25
Ran Cassie's R plate.  

Check R2 for alignment to chr  
[] All RNA reads in file  
[] readnames are in BAM already  
[] Realign with star?  

For STAR bam filter, each read has a fractional coverage determined by mch / cov. If ref:read base is G:G, mch and cov += 1 (unconverted, methylated), else if G:C, cov += 1 (converted). Coverage has to be higher than 3 and fraction has to be higher than 90% for the read to be considered in the final all RNA bam. This makes sense as mch and cov increase at a 1:1 ratio when the bases are not converted, and the bases should not be converted for the methyl sequences. Reference sequence is determined through MD sequence from bam file; independent of bismark.

Did STAR alignment on the rna raw reads, but only 70% of them mapped and the other 30% was too short. But this should be impossible, since all of the reads were taken from the mapping set?? What I think is happening is that the raw reads contain too much nonsense sequence like TSO or R1 or some garbage that is not mapped to the genome, and therefore the read coverage is too low and it is being discarded. Planning on rerunning this with ecker trimming before alignment; not sure if this will help the R2.


# 03/24/25
The bedtools intersect is still not giving alignments to gene regions, just the reads that I can already intersect with (chrG).  
I need a tool that will drag out gene specific alignments.  
Looking towards setting up github issues / Agile today. Issues + commit messages for issues, etc.  
gtf2bed requires an extra newline at the end of the GTF file to properly convert all regions to bed.  

Trying to figure out how to remove the reads that only align to the back of the scaffold.  
Doesn't seem like there is an easy way to adjust for this in terms of the spacer; not sure if STAR reads U (uracil) as T? No good base / letter for declaring a sequence that shouldn't match?  
Should I do independent scaffolds for the different gRNA instead of one complete artificial chromosome?  

Filtering instead by the first few base pairs of the scaffold, since they are distinct sequences. 

wc -l TotalAlignedChrG.rna_reads.sam  
638 TotalAlignedChrG.rna_reads.sam  
grep GTTTTA TotalAlignedChrG.rna_reads.sam | wc -l  
37  
grep GTTTAAG TotalAlignedChrG.rna_reads.sam | wc -l  
2  

```bash
grep GTTTTA TotalAlignedChrG.rna_reads.sam | cut -f1 >> grna_readnames.txt
grep GTTTAAG TotalAlignedChrG.rna_reads.sam | cut -f1 >> grna_readnames.txt
zcat ~/jin_lab/yap/raw_data/S_10/S_10_CKDL250004755-1A_22MKYCLT4_L3_1.fq.gz | grep -A 3 -F -f grna_readnames.txt > grna_reads.fq
sed -i '/^--$/d' grna_reads.fq
awk 'NR % 4 == 1 {header = $0} NR % 4 == 2 {seq = substr($0, 1, 8); print ">" substr(header, 2) "\n" seq}' grna_reads.fq > grna_reads.fa
awk 'NR % 2 == 0' grna_reads.fa | sort -u > grna_primers.txt
rep -F -B 1 -f grna_primers.txt /gpfs/home/asun/jin_lab/yap/raw_data/384RPIndexes.fasta
```

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

TODO cassie wants code that finds a sequence, extracts the upstream and aligns it to another reference.

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
