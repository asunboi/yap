#!/bin/bash

yap default-mapping-config \
--mode mct \
--barcode_version V2 \
--bismark_ref "~/jin_lab/yap/raw_data/ref_w_chrG" \
--genome "~/jin_lab/yap/raw_data/ref_w_chrG/mm10_no_alt_ENCODE_chrL_chrG.fa" \
--chrom_size_path "~/jin_lab/yap/raw_data/ref_w_chrG/mm10_no_alt_ENCODE_chrL_chrG.sizes" \
--gtf "~/jin_lab/yap/raw_data/ref_w_chrG/mm10_no_alt_ENCODE_chrL_chrG.gtf" \
--star_ref "~/jin_lab/yap/raw_data/ref_w_chrG/star" > mct_config.ini
