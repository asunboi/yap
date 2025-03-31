#!/bin/sh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=40000
#SBATCH --time=12:00:00
#SBATCH --partition=highmem
#SBATCH -o /gpfs/home/asun/jin_lab/yap/logs/%x.o%j       # Name of stdout output file
#SBATCH -e /gpfs/home/asun/jin_lab/yap/logs/%x.e%j 

CONFIG_FILE="/gpfs/home/asun/jin_lab/yap/pipeline2_yap_iseq0328/config.yaml"

FASTQ_PATTERN=$(yq -r '.demultiplex.fastq_pattern' $CONFIG_FILE)
OUTPUT_DIR=$(yq -r '.demultiplex.output_dir' $CONFIG_FILE)
CONFIG_PATH=$(yq -r '.demultiplex.config_path' $CONFIG_FILE)

echo $FASTQ_PATTERN
echo $OUTPUT_DIR
echo $CONFIG_PATH

yap demultiplex \
--fastq_pattern $FASTQ_PATTERN \
-o $OUTPUT_DIR \
-j 16 \
--aligner bismark \
--config_path $CONFIG_PATH
