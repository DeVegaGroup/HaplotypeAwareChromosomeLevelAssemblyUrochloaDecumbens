#
# Formatting fasta for alignment in dotplot
#

gunzip lpUroDecu1.fasta.gz

grep '>chromosome' lpUroDecu1.fasta | cut -f 1 -d " " | cut -f 2 -d '>' | grep -v 'unloc'  > udecum_chr.txt



seqtk subseq lpUroDecu1.fasta udecum_chr.txt > udecum_chr.fa

#Manually add chromosome just numbers to RUZI_chr.txt to make ruzi_keyvalue.txt
cp udecum_chr.txt udecum_keyvalue.txt

seqkit replace -p '^(\S+)' -r '{kv}' -k udecum_keyvalue.txt udecum_chr.fa >> Udecum_chr_only_renamed.fasta

gzip Udecum_chr_only_renamed.fasta
