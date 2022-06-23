#!/bin/bash

#get header lines of grep file, remove everything after space and store as *.headers.txt
for i in $(ls -1 *.grep15_8471.txt | sed 's/\.grep15_8471.txt//')
do
awk 'NR % 3 == 1' $i\.grep15_8471.txt > $i\.grep15_8471.headers.txt
sed -i 's/\s.*$//' $i\.grep15_8471.headers.txt
done
for j in $(ls -1 *.grep10_6335.txt | sed 's/\.grep10_6335.txt//')
do
awk 'NR % 3 == 1' $j\.grep10_6335.txt > $j\.grep10_6335.headers.txt
sed -i 's/\s.*$//' $j\.grep10_6335.headers.txt
done
#find matches in corresponding R1.fastq; store the sequence identifier line and R1 sequence in R1matches.txt
for i in $(ls -1 *.R2.grep10_6335.headers.txt | sed 's/\.R2.grep10_6335.headers.txt//')
do
grep -A 1 -f $i.R2.grep10_6335.headers.txt $i.R1.fastq > $i.6335_R1matches.txt
done

for j in $(ls -1 *.R2.grep15_8471.headers.txt | sed 's/\.R2.grep15_8471.headers.txt//')
do
grep -A 1 -f $j.R2.grep15_8471.headers.txt $j.R1.fastq > $j.8471_R1matches.txt
done
#isolate sequence from R1matches.txt files
for i in $(ls -1 *_R1matches.txt | sed 's/\_R1matches.txt//')
do
sed -n 2~3p $i\_R1matches.txt > $i\_R1matches_sequence.txt
done
#get unique sequences; take first 16 characters of each sequence (barcode); add "," and "6335" or "8471" accordingly to end of each line
for i in $(ls -1 *.6335_R1matches_sequence.txt | sed 's/.6335_R1matches_sequence.txt//')
do
sort -u $i.6335_R1matches_sequence.txt > $i.6335_R1matchesunique.txt
cut -c-16 $i.6335_R1matchesunique.txt > $i.6335_R1matchesunique_barcodes.txt
sed -i s/$/-1,6335/ $i.6335_R1matchesunique_barcodes.txt
done

for j in $(ls -1 *.8471_R1matches_sequence.txt | sed 's/.8471_R1matches_sequence.txt//')
do
sort -u $j.8471_R1matches_sequence.txt > $j.8471_R1matchesunique.txt
cut -c-16 $j.8471_R1matchesunique.txt > $j.8471_R1matchesunique_barcodes.txt
sed -i s/$/-1,8471/ $j.8471_R1matchesunique_barcodes.txt
done
#concatenate 6335 and 8471 deletion barcode files per sample
for k in $(ls -1 *_R1matchesunique_barcodes.txt | sed -e 's/\.6335_R1matchesunique_barcodes.txt//' -e 's/\.8471_R1matchesunique_barcodes.txt//')
do
cat $k\.6335_R1matchesunique_barcodes.txt $k\.8471_R1matchesunique_barcodes.txt > $k\.deletionbarcodes.csv
done
rm *grep*headers.txt *R1matches*txt
