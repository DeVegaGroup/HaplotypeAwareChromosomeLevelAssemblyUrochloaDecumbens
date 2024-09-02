#!/bin/bash
#SBATCH -p ei-medium# partition (queue)
#SBATCH -c 4
#SBATCH --mem 200G # memory pool for all cores
#SBATCH -t 0-12:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=END,FAIL # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address

#SBATCH --array=0-1

source busco-5.3.2

mapfile -t REF < assemblies.txt
mapfile -t NAME < prefix.txt


genome=${REF[${SLURM_ARRAY_TASK_ID}]}
out=${NAME[${SLURM_ARRAY_TASK_ID}]}
db=/ei/software/testing/busco/5.3.2/datasets/poales_odb10

wd=$(pwd) #must be run from directory you want to be in.

cd $wd

mkdir ${out}

cd ${out}

busco -i ${genome} -o ${out} -l ${db} -f --offline -c 4 --mode genome
