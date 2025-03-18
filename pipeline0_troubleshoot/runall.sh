#!/bin/bash

rp_primer_name="A1"

output=$(grep -A 1 $rp_primer_name /gpfs/home/asun/cemba_data/files/random_index_v2/random_index_v2.fa | tail -n 1)

echo $output