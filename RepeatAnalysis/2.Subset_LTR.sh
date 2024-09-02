#
#Decided to just analyse LTR across chromosomes so needed to subset for them

grep 'Chr_' lpUroDecu1.renamed.fasta.mod.EDTA.intact.gff3 | grep -v '_u1' | grep -v '_u2' | grep 'LTR' > lpUroDecu1.renamed.fasta.mod.EDTA.intact_CHR_LTR_ONLY.gff3
