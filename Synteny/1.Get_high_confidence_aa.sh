#
# Subset amino acid fasta to include only high confidence protein coding genes
#This is a two step process becuase firstly need to identify which protein sequences are considered high confidence. This can be done by looking at a table that has been produced by the annotation pipeline and can be used to create a list of proteins that are high confidence then use seqtk to subset fasta.
#

grep 'Chromosome' Urdoc_EIv1.0.release.gff3.final_table.tsv | grep -v 'unloc' | grep 'protein_coding_gene' | grep 'High'  | cut -f 1 > highconf_protein_coding_on_chromosomes.txt

source seqtk-1.3_CBG

seqtk subseq Urdoc_EIv1.0.release.gff3.pep.fasta highconf_protein_coding_on_chromosomes.txt > Urdoc_EIv1.0.release.gff3.pep_chr_only.fasta
