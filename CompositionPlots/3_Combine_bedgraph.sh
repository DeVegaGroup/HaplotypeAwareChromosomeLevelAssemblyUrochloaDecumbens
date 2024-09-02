#!/bin/bash
#SBATCH -p ei-short # partition (queue)
#SBATCH -c 1
#SBATCH --mem 32G # memory pool for all cores
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address

grep 'Chromosome' ruz.merged.bed | grep -v 'unloc' | awk 'BEGIN{OFS="\t"}{print $0, "Urochloa ruziziensis"}'  > ruz.merged.chr.bed

grep 'Chromosome' briz.merged.bed | grep -v 'unloc' | awk 'BEGIN{OFS="\t"}{print $0, "Urochloa brizantha"}'  > briz.merged.chr.bed

grep 'Chromosome' decum.merged.bed | grep -v 'unloc' | awk 'BEGIN{OFS="\t"}{print $0, "Urochloa decumbens"}'  > decum.merged.chr.bed

cat *merged.chr.bed > urochloa.merged.chr.bed

sed  -i '1i seq_name tstart tend qname' urochloa.merged.chr.bed
