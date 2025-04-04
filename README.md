# documents
Stores all relevant input and output documents such as the mapping summary htmls from each run.

# figures
Stores generated figures from any scripts.

# logs
Slurm logs ordered by job names and ID.

# notebooks
Universal jupyter notebooks for analysis.

# raw_data
Links to raw data files and all references genomes.

# src
All source scripts used for analysis in pipelines. Source scripts will also be placed in their respective pipelines and described.

# web
All material from internet.

# Pipelines 
Pipelines are in ascending numerical order based on the pipeline's dependencies; pipeline 0 for no dependencies, pipeline 1-x depends on output of all prior pipelines.

## pipeline0_bt2_local_alignment
Pipeline 0 Bowtie 2 Local Alignment: aligning raw files locally against different artificial chromosomes.

## pipeline0_troubleshoot
Pipeline 0 Troubleshooting: initial tests to map subsets or individiual wells using bowtie or STAR to get gRNA.

## pipeline1_chrG_references
Pipeline 1 chrG References: building references for pipelines - ecker lab with lambda and artificial guide chromosome, guide chromosome with spacer, and mulitple decoy chromosomes.

## pipeline2_yap
Pipeline 2 Yap: original run to test the ecker lab pipeline on S_5 plate downsampled to 1% using just the base ENCODE mm38 genome.

## pipeline2_yap_chrG
Pipeline 2 Yap chrG: running ecker lab pipeline on S_5 plate downsampled to 1% with basic ENCODE + chrG reference.

## pipeline2_yap_iseq0328
Pipeline 2 Yap iseq0328: running ecker lab pipeline on March 28 iSeq experiment, detected gRNA through grep based methods but no alignment through ecker pipeline.

## pipeline2_yap_iseq0328_2
Pipeline 2 Yap iseq0328 Run 2: Modified ecker lab trimming in cemba_data/files/smk/bismark/mct.smk to remove TSO trimming since some of our gRNA was downstream of the TSO trimming. Running ecker lab pipeline on March 28 iSeq experiment, detected gRNA through grep based methods but no alignment through ecker pipeline still.

## pipeline2_yap_r
Pipeline 2 Yap R: Running ecker lab pipeline on full R plate with basic ENCODE + chrG reference.

## pipeline2_yap_s5
Pipeline 2 Yap s5: Running ecker lab pipeline on full S5 plate with basic ENCODE + chrG reference.

## pipeline2_yap_s10
Pipeline 2 Yap s10: Running ecker lab pipeline on full S10 plate with basic ENCODE + chrG reference.

## pipeline3_bc_troubleshoot
Pipeline 3 Barcode Troubleshooting: After gRNA detection in S10 plate, extracting all RNA aligned reads + all gRNA aligned reads and profiling them based on protospacer match and well location. Testing if R1 and R2 have different capture rates, since ecker alignment only tests for R1.

