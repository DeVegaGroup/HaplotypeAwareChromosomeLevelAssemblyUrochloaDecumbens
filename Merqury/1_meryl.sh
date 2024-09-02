#!/bin/bash
#SBATCH -p ei-largemem# partition (queue)
#SBATCH -c 32
#SBATCH --mem 1T # memory pool for all cores
#SBATCH -t 1-00:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=END,FAIL # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address
#SBATCH --array=0-2

source merqury-1.3

mapfile -t INPUTS  <  /ei/.project-scratch/d/df141853-c5bd-4514-96f5-dbced5c97fd0/results/ManualCuration/QC/Merqury/reads.txt # file contains a list of inputs here assemblies
mapfile -t NAMES < /ei/.project-scratch/d/df141853-c5bd-4514-96f5-dbced5c97fd0/results/ManualCuration/QC/Merqury/prefix.txt




reads=${INPUTS[${SLURM_ARRAY_TASK_ID}]}

prefix=${NAMES[${SLURM_ARRAY_TASK_ID}]}

meryl k=21 threads=32 memory=1000g count output $prefix.meryl $reads
