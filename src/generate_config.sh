#!/bin/bash

yap default-mapping-config \
--mode mct \
--barcode_version V2 \
--bismark_ref "~/jin_lab/yap/raw_data/references" \
--genome "~/jin_lab/yap/raw_data/references/mm10_no_alt_analysis_ENCODE_with_chrL.fa" \
--chrom_size_path "~/jin_lab/yap/raw_data/references/mm10_no_alt_analysis_ENCODE_with_chrL.sizes" \
--gtf "~/jin_lab/yap/raw_data/references/ENCFF871VGR.gtf" \
--star_ref "~/jin_lab/yap/raw_data/references/star" > mct_config.ini
