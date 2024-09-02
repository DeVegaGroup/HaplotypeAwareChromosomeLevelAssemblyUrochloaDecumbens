#!/bin/bash
#SBATCH -p ei-largemem # partition (queue)
#SBATCH -c 16
#SBATCH --mem 800G # memory pool for all cores
#SBATCH -t 0-01:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address

source MCScanX-2 # woudl recommend using different version as this will be retired soon.

MCScanX ud/ud
