# Common Mitochondrial Deletions in RNA-Seq: Evaluation of Bulk, Single-Cell and Spatial Transcriptomic Datasets

This repository contains code accompanying the following paper:
<citation here>

## Introduction
In the paper, *Common Mitochondrial Deletions in RNA-Seq: Evaluation of Bulk, Single-Cell and Spatial Transcriptomic Datasets*, we evaluated a variety of RNA-Seq datasets for common mitochondrial DNA (mtDNA) deletions using the bioinformatics tool Splice-Break. The scripts within this repository can be used for processing data in conjunction with Splice-Break.

Each directory contains README files with usage instructions.
### Processing_FASTQ_from_GEO
This directory contains two command-line scripts can be used to convert fastq files downloaded from GEO using default settings into a format that is suitable for Splice-Break, and will run Splice-Break when executed. `ProcessSE_SRR_for_SB.sh` can be run on single-end fastq files and `ProcessPE_SRR_for_SB.sh` can be run on paired-end fastq files.

### Cumulative Metrics
This directory contains an R script can be used to calculate cumulative metrics we described in the manuscript from the Splice-Break output files labeled *LargeMTDeletions_LR-PCR_STRINGENT_pos357-15925.txt*.

### Parsing_for_Deletions
This directory contains two scripts that can be used to search for and isolate reads that contain the 8471-13449 mtDNA "Common Deletion" and the 6335-13999 mtDNA deletion, respectively.

## Installation & Dependencies
This code is compatible with Python3 and base R.
## Contact
Questions can be reported under the *Issues* tab in this repository.

## Acknowledgements
## License
