#!/usr/bin/env bash
set -ev

# Empty test directory of test output files
rm -f tests/seq_*

# Test for required packages
Rscript check_for_required_packages.R

# Test for sequence filtering (positive and negative selection)
Rscript seqFilt.R tests/Data/Undetermined_S0_L001_I1_001.fastq.gz -o tests/seq_filt_I1.fastq -s CGTACTAG --compress
filt_test_len=$(zcat tests/seq_filt_I1.fastq.gz | sed -n '2~4p' | wc -l)
if [ ! $filt_test_len = 50 ]; then
    exit 1
fi

Rscript seqFilt.R tests/Data/Undetermined_S0_L001_I1_001.fastq.gz -o tests/seq_negfilt_I1.fastq -s CGTACTAG --compress -n
negfilt_test_len=$(zcat tests/seq_negfilt_I1.fastq.gz | sed -n '2~4p' | wc -l)
if [ ! $negfilt_test_len = 50 ]; then
    exit 1
fi

# Test for sequence filtering by overlapping indices
Rscript seqFilt.R tests/seq_filt_I1.fastq.gz tests/seq_negfilt_I1.fastq.gz -o tests/seq_A_overlap_I1.fastq tests/seq_B_overlap_I1.fastq --compress
ovlp_A_test_len=$(zcat tests/seq_A_overlap_I1.fastq.gz | sed -n '2~4p' | wc -l)
ovlp_B_test_len=$(zcat tests/seq_B_overlap_I1.fastq.gz | sed -n '2~4p' | wc -l)
if [ ! $ovlp_A_test_len = 0 ] | [ ! $ovlp_B_test_len = 0 ]; then
    exit 1
fi

# Test for index filtering
zcat tests/seq_filt_I1.fastq.gz | sed -n '1~4p' > tests/seq_index.txt
head tests/seq_index.txt -n 3

Rscript seqFilt.R tests/Data/Undetermined_S0_L001_R1_001.fastq.gz -o tests/seq_filt_R1.fastq -i tests/seq_index.txt --compress
idx_test_len=$(zcat tests/seq_filt_R1.fastq.gz | sed -n '2~4p' | wc -l)
if [ ! $idx_test_len = 50 ]; then
    exit 1
fi

# Cleanup
rm -f tests/seq_*

echo "Passed all tests."
exit
