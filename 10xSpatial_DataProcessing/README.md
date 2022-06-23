# 10x Genomics Spatial Transcriptomics Data Processing
## Split bam per cluster
## Find Deletion Barcodes
Spatial bam files were converted to fastq files using the 10x Genomics program `bamtofastq_linux`. This resulted in 3 sets of fastq files per sample (see https://davetang.org/muse/2018/06/06/10x-single-cell-bam-files/ for more information):
1. Read 1 - contains 16 nucleotide barcode sequence followed by 10 nucleotide UMI
2. Read 2 - contains cDNA nucleotide sequence
3. Index 1 - contains 8 nucleotide index sequence which is used for multiplexing

Read 2 fastq files were used for analysis in Splice-Break because they contained sequencing data. The two "parsing for deletions" scripts were also run on these files in order to output text files containing the sequence identifier lines and sequences for reads containing the 8471-13449 deletion and the 6335-13999 deletion.
# Usage
This script can be run in a directory containing:
* Text files output by [parsing for deletions scripts](https://github.com/aomidsalar/RNA-Seq_SpliceBreak/tree/main/Parsing_for_Deletions)
* R1 fastq files (not compressed)

It will output a file labeled `Sample.deletionbarcodes.csv`, which contains 2 columns:
* Column one contains barcodes that contained either the 6335-13999 or 8471-13449 deletion
* Column two lists which deletion was present (written as `6335` or `8471`)