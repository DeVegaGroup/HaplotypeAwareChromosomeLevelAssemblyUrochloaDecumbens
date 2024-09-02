#!/bin/bash
#SBATCH -p ei-medium# partition (queue)
#SBATCH -c 2
#SBATCH --mem 16G # memory pool for all cores
#SBATCH -t 0-04:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=END,FAIL # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address

interactive --mem 8G

source  merqury-1.3
meryl union-sum output UroDecum.meryl cell*.meryl
