#!/bin/bash
#SBATCH -J EDTA -c 16 --mem 350G -p ei-medium

CPUS=16
i=lpUroDecu1.renamed.fasta #$1 #my fasta assembly

source  package 3bba398c-2ecb-408a-82f2-333904dc9b3f

#mkdir -p ${i}_output
#ln -s $PWD/${i} $PWD/${i}_output # use full paths!
#cd ${i}_output
#time EDTA.pl --anno 1 --step all --species others -t ${CPUS} --genome ${i} && touch ${i}.edta.done

#resume:
EDTA.pl --anno 1 --step anno --species others -t ${CPUS} --genome ${i} && touch ${i}.edta.done
