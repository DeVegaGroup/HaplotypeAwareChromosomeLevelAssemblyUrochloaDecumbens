#!/bin/bash
#SBATCH -p ei-largemem # partition (queue)
#SBATCH -c 32
#SBATCH --mem 1T # memory pool for all cores
#SBATCH -t 3-00:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address


source samtools-1.9
samtools view -h mapped_sorted_omnic.bam | singularity exec ~/software_workshop/images/pretextMap.img /opt/miniconda3/bin/PretextMap -o UDecumbens.pretext --sortby length --sortorder descend
