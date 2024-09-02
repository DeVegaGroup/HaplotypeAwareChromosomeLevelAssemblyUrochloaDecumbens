#
#3. Subset and rename chromosomes in gff
#McScanx works on all versus all and blast can take a long time to run so subsetted to just the chromosomes. It also expects the chromosome number in a particular format 2 letter species name and number. Here ud for Urochloa decumbens.

grep 'Chromosome' Urdoc_EIv1.0.release.gff3 | grep -v 'unloc' > Urdoc_EIv1.0.MCscanX.gff3

sed -i 's/Chromosome_/ud/g' Urdoc_EIv1.0.MCscanX.gff3
