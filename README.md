# RNA-Seq Splice-Break
## Processing Scripts Used

### GEO FASTQ file Processing
The two scripts (`ProcessPE_SRR_for_SB.sh` and `ProcessSE_SRR_for_SB.sh`) can be used to format fastq files downloaded from GEO using fastq-dump with default settings into one that is appropriate for Splice-Break, and will run Splice-Break using the option to skip pre Alignment. The main steps of these scripts are as follows:
1. `output` and `logs` directories are made, both of which are where Splice-Break data is deposited
2. The sequence identifier lines in the fastq files are modified.
    
    If single-end, a "/1" is added to the end of each sequence identifier line, which is the format that MapSplice recognizes.
    (ex. @SRR13614911.1.1 1 length=75 is modified to @SRR13614911.1.1 1 length=75/1)
    
    If paired-end, a "/1" is added to the end of each sequence identifier line in the read 1 fastq file. A "/2" is added to the end of each sequence identifier line in the read 2 fastq file while ensuring the beginning portion of the sequence identifier lines are identical to those in read 1
    (ex. @SRR13614911.1.2 1 length=75 is modified to @SRR13614911.1.1 1 length=75/2)
3. The modified, updated fastq files are saved with endings ".R1.fastq" and ".R2.fastq", which Splice-Break will recognize. The original fastq files downloaded from GEO are deleted.
4. The appropriate version of Splice-Break (single end of paired end) is run using the option to skip pre Alignment.

* **This script must be executed in the directory containing the GEO-downloaded fastq files, ending in "_1.fastq" and/or "_2.fastq".**
* **The path to Splice-Break must be updated prior to executing the script.**

### Parsing fastq files for Deletions
The two scripts (`grep_6335-13999deletion.sh` and `grep_8471-13449deletion.sh`) can be used to isolate 6335-13999 and 8471-13449 deletions, respectively, in fastq files. They will output text files containing each sequence that containined the deletion string and its corresponding sequence identifier line.
The input files must end in ".fastq" to be executed in this script. The script will loop through each ".fastq" and output one text file per sample containing the deletion sequences (ex. executing the script `grep_6335-13999deletion.sh` on *Sample1.R1.fastq* will output *Sample1.R1.grep10_6335.txt*; executing the script `grep_8471-13449deletion.sh` on *Sample1.R2.fastq* will output *Sample1.R2.grep15_8471.txt*).
This script can loop through all ".fastq" files in the directory which it is executed.
