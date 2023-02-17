#!/bin/bash

for i in $(ls -1 *.fastq | sed 's/\.fastq//')
do
grep -B 1 CTCCGTAGACCTAACCTGAC $i.fastq > $i.grep10_6335.txt
done
