#!/bin/bash
#SBATCH -p ei-medium # partition (queue)
#SBATCH -c 4
#SBATCH --mem 100G # memory pool for all cores
#SBATCH -t 0-10:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address



source bioperl-1.6.1


perl rapid_join.pl -fa data/ref.fa -tpf rapid_prtxt_XL.tpf -csv chrs.csv -out Udecum_v1.1.0.fasta
