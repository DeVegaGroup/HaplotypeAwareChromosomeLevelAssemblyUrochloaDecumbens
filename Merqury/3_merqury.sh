#!/bin/bash
#SBATCH -p ei-medium# partition (queue)
#SBATCH -c 2
#SBATCH --mem 16G # memory pool for all cores
#SBATCH -t 0-07:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=END,FAIL # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address


meryl=/ei/.project-scratch/d/df141853-c5bd-4514-96f5-dbced5c97fd0/results/ManualCuration/Paper/merqury/UroDecum.meryl # m
ref=/ei/.project-scratch/d/df141853-c5bd-4514-96f5-dbced5c97fd0/results/ManualCuration/Paper/lpUroDecu1.fasta
out=UroDecum

source merqury-1.3
merqury.sh $meryl $ref $out > ${out}.log
