#!/bin/bash
#SBATCH -p ei-long # partition (queue)
#SBATCH -c 16
#SBATCH --mem 400G # memory pool for all cores
#SBATCH -t 0-12:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address


source diamond-2.0.15

prot=./Urdoc_EIv1.0.release.gff3.pep_chr_only.fasta

out=ud


diamond makedb --in ${prot} -d ${out}
diamond blastp -e 1e-5 -p 16  -q ${prot} -d ${out} -a ${out}.vs.self
diamond view -a ${out}.vs.self.daa -o ${out}.blast
