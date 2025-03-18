#!/bin/bash

faSize -detailed -tab mm10_no_alt_analysis_ENCODE_with_chrL.fa > mm10_no_alt_analysis_ENCODE_with_chrL.sizes

faSize -detailed -tab mm10_no_alt_ENCODE_chrL_chrG.fa > mm10_no_alt_ENCODE_chrL_chrG.sizes

cat mm10_no_alt_analysis_ENCODE_with_chrL.fa chrG.fa > mm10_no_alt_ENCODE_chrL_chrG.fa
cat ENCFF871VGR.gtf chrG.gtf > mm10_no_alt_ENCODE_chrL_chrG.gtf