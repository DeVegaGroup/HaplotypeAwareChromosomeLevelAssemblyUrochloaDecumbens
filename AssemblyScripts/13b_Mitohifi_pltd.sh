#!/bin/bash
#SBATCH -p ei-long # partition (queue)
#SBATCH -c 4
#SBATCH --mem 400G # memory pool for all cores
#SBATCH -t 7-00:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address

source /ei/software/staging/RCSUPPORT-1484/stagingloader #mitohifi


DRAFT_ASSEMBLY=$1
RELATED_MITOGENOMES=$2


mitohifi.py -c ${DRAFT_ASSEMBLY} -f ${RELATED_MITOGENOMES}.fasta -g ${RELATED_MITOGENOMES}.gb -t 32 -a plant -d 
