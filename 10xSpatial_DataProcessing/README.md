# 10x Genomics Spatial Transcriptomics Data Processing
## Split bam per cluster
## R Scripts ?? clustering, images
## Find Deletion Barcodes
Spatial bam files were converted to fastq files using the 10x Genomics program `bamtofastq_linux`. This resulted in 3 sets of fastq files per sample (see https://davetang.org/muse/2018/06/06/10x-single-cell-bam-files/ for more information):
1. Read 1 - contains 16 nucleotide barcode sequence followed by 10 nucleotide UMI
2. Read 2 - contains cDNA nucleotide sequence
3. Index 1 - contains 8 nucleotide index sequence which is used for multiplexing

Read 2 fastq files were used for analysis in Splice-Break and 
