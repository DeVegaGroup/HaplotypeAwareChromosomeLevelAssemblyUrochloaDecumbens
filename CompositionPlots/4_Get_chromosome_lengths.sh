#!/bin/bash
#SBATCH -p ei-short # partition (queue)
#SBATCH -c 2
#SBATCH --mem 16G # memory pool for all cores
#SBATCH -t 0-00:45 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address



##
# Get chromosome lengths
##

samtools faidx ../lpUroDecu1_CHR_only.fasta

cut -f 1,2 ../lpUroDecu1_CHR_only.fasta.fai > chromosome_lengths.txt

sed  -i '1i seq_name seq_len' chromosome_lengths.txt
