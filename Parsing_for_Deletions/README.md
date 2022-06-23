# Parsing FASTQ files for Deletions
The two scripts (`grep_6335-13999deletion.sh` and `grep_8471-13449deletion.sh`) can be used to isolate 6335-13999 and 8471-13449 deletions, respectively, in fastq files. They will output text files containing each sequence that containined the deletion string and its corresponding sequence identifier line.

The input files must end in ".fastq" to be executed in this script. The script will loop through each ".fastq" and output one text file per sample containing the deletion sequences (ex. executing the script `grep_6335-13999deletion.sh` on *Sample1.R1.fastq* will output *Sample1.R1.grep10_6335.txt*; executing the script `grep_8471-13449deletion.sh` on *Sample1.R2.fastq* will output *Sample1.R2.grep15_8471.txt*).

This script can loop through all ".fastq" files in the directory which it is executed.