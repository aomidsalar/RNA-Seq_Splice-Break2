#!/bin/bash
# Make output & log directories
mkdir output
mkdir logs
for i in $(ls -1 *_1.fastq | sed 's/_1.fastq//')
do
# Make a copy of each SRA fastq file with "/1" at end of each sequence identifier line
awk -v "n=$n" 'NR % 4 == 1 {$0 = $0 "/1"} {print}' $i\_1.fastq > $i.R1.fastq
# Remove SRA fastq file
rm $i\_1.fastq
done
# Begin Splice-Break single end script, with the option to skip pre Alignment
nohup /path/to/SpliceBreak/Splice-Break2_single-end.sh input_directory/ output_directory/ logs_directory/ SB_Path/ --align=yes --ref=rCRS --fastq_keep=no --skip_preAlign=yes > nohup.out &
