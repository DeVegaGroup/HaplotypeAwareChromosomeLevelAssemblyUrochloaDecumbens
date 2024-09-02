#!/bin/bash
#SBATCH -p ei-short # partition (queue)
#SBATCH -c 1
#SBATCH --mem 50G # memory pool for all cores
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address
source seqtk-git20160921
source perl-5.22.1

reference=ref.fa

perl /ei/.project-scratch/d/df141853-c5bd-4514-96f5-dbced5c97fd0/scripts/rapid_split.pl -fa $reference
