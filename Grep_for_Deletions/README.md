# Grep FASTQ files for Deletions
The three scripts (`grep_6335-13999deletion.sh`, `./grep_7816-14807deletion.sh`, and `grep_8471-13449deletion.sh`) can be used to isolate the 6335-13999, 7816-14807, and 8471-13449 deletions, respectively, in fastq files. They will output text files containing each sequence that containined the deletion string and its corresponding sequence identifier line.

## Usage
The input files must end in ".fastq" for this script to execute.  
Each script will loop through each ".fastq" file in the directory that it is run, and will output one text file per fastq containing the full sequence (i.e., line 2 of fastq read) and identifier line (i.e., line 1 of fastq read) for each read containing a deletion.  
`./grep_6335-13999deletion.sh` will output text files ending with *.grep10_6335.txt* 
`./grep_7816-14807deletion.sh` will output text files ending with *.grep_7816.txt*
`./grep_8471-13449deletion.sh` will output text files ending with *grep15_8471.txt*

