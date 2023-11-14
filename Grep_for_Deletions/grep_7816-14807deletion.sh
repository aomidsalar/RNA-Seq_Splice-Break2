#!/bin/bash

for i in $(ls -1 *.fastq | sed 's/\.fastq//')
do
grep -B 1  TCATCGACCTCCCCACCC $i.fastq | grep -B1 ATCCTAGT | grep -B1 GAAACTTCGG > $i.grep_7816.txt
done
