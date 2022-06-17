#!/bin/bash

for i in $(ls -1 *.fastq | sed 's/\.fastq//')
do
grep -B 1 CAAACTACCACCTACCTCCCTCACCATTGG $i.fastq > $i.grep15_8471.txt
done
