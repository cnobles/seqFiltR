# seqFiltR
[Dev] R-based tool for filtering a sequence file(s) based on supplied indices or another sequence file.

## Description
Sequence files may sometimes contain only a few reads relevant to an analysis, or host a number of reads needing to be removed. Removal of unwanted sequences, or selection of desired sequences, can help with reducing downstream analysis and requirements. The **seqFiltR** tool is designed to do both positive and negative selection by indices (matching sequence names) for fasta and fastq files. Further, if two fasta or fastq files are provided (such as from paired-end sequencing, R1 and R2) then only the intersect (positive selection) or unique (negative selection) reads will be selected. 

## Install

## Usage
Below are a number of different filtering processes that **seqFiltR** can be used for:

### Filter reads based on read names or indices
Given a file containing indices matching the sequence names within the provided fastq or fasta file, **seqFiltR** can preform either positive or negative (**[-n]**) filtering and return the filtered sequences as a fastq or fasta file, based on output file extension. If an output file is not provided, the filtered sequences will be printed to the terminal in the input file format.

```
# Select all sequence that match the sequence names in index.txt
Rscript /path/to/seqFilt.R test.fastq -o test.filt.fastq -i index.txt

# Select all sequences that don't match the sequence names in index.txt
Rscript /path/to/seqFilt.R test.fastq -o test.filt.fastq -i index.txt -n
```

### Filter two fast(a/q) files for intersecting or unique read indices
If two fasta or fastq files are provided, then **seqFiltR** will return two output files of the desired format containing the intersecting or unique (**[-n]** when two files are provided) sequences in each file. This process requires sequence names to match between both files, but can be controlled by the **[--readNamePattern]** argument, which will be a regular expression applied to sequence names to select specific parts of the sequence name (see **Arguments** section for default). 

```
# Filter test.R1 and test.R2 files for sequence names matching between the two files
Rscript /path/to/seqFilt.R test.R1.fastq test.R2.fastq -o test.R1.filt.fastq test.R2.filt.fastq

# Filter test.R1 and test.R2 files for sequence names that do not appear in the other file
Rscript /path/to/seqFilt.R test.R1.fastq test.R2.fastq -o test.R1.filt.fastq test.R2.filt.fastq -n 
```

### Filter a fast(a/q) file for sequences containing a specific nucleotide sequence
Providing a nucleotide sequence (DNA or RNA, ambiguous nucleotide codes accepted) and a fastq or fasta file will return an output file, of the specified format, with sequences which contained or did not contain (**[-n]**) sequences matching the provided nucleotide sequence. The **[-m]** parameter can be used to specify the mismatches tolerated for matching.

```
# Filter test.fastq sequences for sequences containing ACTC...CTAC, or with up to 3 mismatches
Rscript /path/to/seqFilt.R test.fastq -o test.filt.fastq -s ACTCTACGGCATTAGGCTAC
Rscript /path/to/seqFilt.R test.fastq -o test.filt.fastq -s ACTCTACGGCATTAGGCTAC -m 3

# Filter test.fastq sequence for sequences not containing ACTC...CTAC, or up to 3 mismatches
Rscript /path/to/seqFilt.R test.fastq -o test.filt.fastq -s ACTCTACGGCATTAGGCTAC -n 
Rscript /path/to/seqFilt.R test.fastq -o test.filt.fastq -s ACTCTACGGCATTAGGCTAC -m 3 -n
```

## Arguments



## Dependencies
