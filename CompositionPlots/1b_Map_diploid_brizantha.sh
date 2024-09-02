#!/bin/bash
#SBATCH -p ei-largemem # partition (queue)
#SBATCH -c 32
#SBATCH --mem 1T # memory pool for all cores
#SBATCH -t 2-00:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address


source package 222eac79-310f-4d4b-8e1c-0cece4150333

ref=/ei/.project-scratch/d/df141853-c5bd-4514-96f5-dbced5c97fd0/results/ManualCuration/Paper/lpUroDecu1.fasta
R1=/ei/projects/d/df141853-c5bd-4514-96f5-dbced5c97fd0/brizanthus/Diploid/Ubrizantha-B105.clean.1.fq.gz
R2=/ei/projects/d/df141853-c5bd-4514-96f5-dbced5c97fd0/brizanthus/Diploid/Ubrizantha-B105.clean.2.fq.gz
out=briz

minimap2 -t 32 -ax sr ${ref} ${R1} ${R2}  > ${out}.sam
