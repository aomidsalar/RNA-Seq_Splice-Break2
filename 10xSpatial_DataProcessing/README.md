# 10x Genomics Spatial Transcriptomics Data Processing
## Split bam per cluster
This script splits a pooled bam file to create cluster-specific bam files given a list of barcodes and their associated cluster. 

### Usage
The input files required for this are (1) BAM file for each sample, from 10x Genomics spatial transcriptomics pipeline; and (2) CSV file with two columns ("Barcode" and "Cluster") which contains the barcode sequences and corresponding cluster designations for each sample which was generated from Seurat Clustering.


split_bam.py [-h] [--bam BAM] [--out-root OUT_ROOT] [--csv CSV]
 
optional arguments:

  -h, --help &emsp; show this help message and exit  
  --bam BAM &emsp; Input BAM file  
  --out-root OUT_ROOT &emsp; Root directory to write output BAMs to  
  --csv CSV &emsp; CSV file with two columns: barcode and cluster 

## Find Deletion Barcodes
This script finds the barcode sequences associated with reads containing 6335-13999 or 8471-13449 mtDNA deletions.  
Spatial bam files were converted to fastq files using the 10x Genomics program [`bamtofastq_linux`](https://support.10xgenomics.com/docs/bamtofastq). This resulted in 3 sets of fastq files per sample (more information [here](https://davetang.org/muse/2018/06/06/10x-single-cell-bam-files/)):
1. Read 1 - contains 16 nucleotide barcode sequence followed by 10 nucleotide UMI
2. Read 2 - contains cDNA nucleotide sequence
3. Index 1 - contains 8 nucleotide index sequence which is used for multiplexing

Read 2 fastq files were used for analysis in Splice-Break because they contained sequencing data. The two "grep for deletions" scripts were also run on these files in order to output text files containing the sequence identifier lines and sequences for reads containing the 8471-13449 deletion and the 6335-13999 deletion.
### Usage
This script can be run in a directory containing:
* Text files output by [grep for deletions scripts](https://github.com/aomidsalar/RNA-Seq_Splice-Break2/tree/main/Grep_for_Deletions)
* R1 fastq files (not compressed)

It will output a file labeled `Sample.deletionbarcodes.csv`, which contains 2 columns:
* Column one contains barcodes that contained either the 6335-13999 or 8471-13449 deletion
* Column two lists which deletion was present (written as `6335` or `8471`)

