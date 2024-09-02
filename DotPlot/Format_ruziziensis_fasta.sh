#
# Formatting fasta for alignment in dotplot
#

seqtk subseq Embrapa_Uruz_v1.fasta RUZI_chr.txt > Ruzi_chr_only.fasta


#Manually add chromosome just numbers to RUZI_chr.txt to make ruzi_keyvalue.txt
cp RUZI_chr.txt ruzi_keyvalue.txt


source package 46a62eca-4f8f-45aa-8cc2-d4efc99dd9c6 # seqkit v 0.12.0

seqkit replace -p '^(\S+)' -r '{kv}' -k ruzi_keyvalue.txt Ruzi_chr_only.fasta >> Ruzi_chr_only_renamed.fasta

gzip Ruzi_chr_only_renamed.fasta
