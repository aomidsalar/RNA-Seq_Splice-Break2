# Common Mitochondrial Deletions in RNA-Seq: Evaluation of Bulk, Single-Cell and Spatial Transcriptomic Datasets

This repository contains code accompanying the following paper:
<citation here>

## Introduction
In the paper, *Common Mitochondrial Deletions in RNA-Seq: Evaluation of Bulk, Single-Cell and Spatial Transcriptomic Datasets*, we evaluated a variety of RNA-Seq datasets for common mitochondrial DNA (mtDNA) deletions using the bioinformatics tool [Splice-Break2](https://github.com/brookehjelm/Splice-Break2). The scripts within this repository were used for processing our data in conjunction with Splice-Break.

Each directory contains README files with usage instructions.
### Data_Availability_and_Accession
This directory contains references to the studies used in this paper and their corresponding accession information.
### Processing_FASTQ_from_GEO
This directory contains two command-line scripts can be used to convert fastq files downloaded from GEO using default settings into a format that is suitable for Splice-Break, and will run Splice-Break when executed. `ProcessSE_SRR_for_SB.sh` can be run on single-end fastq files and `ProcessPE_SRR_for_SB.sh` can be run on paired-end fastq files.

### Grep_for_Deletions
This directory contains two scripts that can be used to search for and isolate reads that contain the 8471-13449 mtDNA "Common Deletion" and the 6335-13999 mtDNA deletion, respectively.
  
### 10xSpatial_DataProcessing
This directory contains two scripts: one that can be used to split 10x Genomics bam files into cluster-specific bam files and another to extract barcodes from reads containing a 6335-13999 or 8471-13449 deletion.
  
### Spatial_Processing_Seurat
This directory contains the R scripts used for Seurat clustering and tissue image annotation.
  
## Contact

## Acknowledgements
