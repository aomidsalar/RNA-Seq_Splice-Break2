#!/bin/bash
# Make output & log directories
mkdir output
mkdir logs
# Make a copy of each Read 1 SRA fastq file with "/1" at end of each sequence identifier line
for i in $(ls -1 *_1.fastq | sed 's/\_1.fastq//')
do
awk -v "n=$n" 'NR % 4 == 1 {$0 = $0 "/1"} {print}' $i\_1.fastq > $i.R1.fastq
rm $i\_1.fastq
done
# Make a copy of each Read 2 SRA fastq file with "/2" at end of each sequence identifier line; make sure sequence identifier lines match
for i in $(ls -1 *_2.fastq | sed 's/\_2.fastq//')
do
awk -v "n=$n" 'NR % 4 == 1 {$0 = $0 "/2"} {print}' $i\_2.fastq > $i.R2.fastq
sed -i 's/.2 /.1 /g' $i.R2.fastq
rm $i\_2.fastq
done
# Begin Splice-Break single end script, with the option to skip pre Alignment
nohup /path/to/SpliceBreak/Splice-Break2_paired-end.sh input_directory/ output_directory/ logs_directory/ /path/to/SpliceBreak/ --align=yes --ref=rCRS --fastq_keep=no --skip_preAlign=yes > nohup.out &
