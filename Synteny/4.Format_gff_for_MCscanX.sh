#
#MCScanx expects gff in a simplified version:
#Chr     Gene            Start   End
#I want only mrna (protein coding) and only High confidence (already converted chromosome names and numbers)
#

grep 'mRNA' Urdoc_EIv1.0.MCscanX.gff3 | grep 'High' | awk '{print $1, $4, $5, $9}' | cut -d ; -f 1  |  sed 's/ID=//g' | awk '{OFS=\t}{$1, $4, $2, $3}' > ud.gff
