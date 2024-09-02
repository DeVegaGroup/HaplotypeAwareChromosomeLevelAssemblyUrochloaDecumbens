#!/bin/bash -e
#SBATCH -p ei-medium # partition (queue)
#SBATCH -c 8
#SBATCH --mem 400G # memory pool for all cores
#SBATCH -t 1-00:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address
minimap2 -ax map-hifi try1.hic.p_utg.fasta $fastqs -t 64| samtools view -@ 64 -Sb -| samtools sort -o utg.p.hifi.sorted.bam -@ 32 -
samtools index -@ 32 utg.p.hifi.sorted.bam

mosdepth -t 12 -b 50000 -Q 1 -F 3840 utg.p_50kb utg.p.hifi.sorted.bam
