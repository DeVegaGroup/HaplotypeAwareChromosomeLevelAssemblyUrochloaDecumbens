#!/bin/bash
#SBATCH -p ei-largemem # partition (queue)
#SBATCH -c 16
#SBATCH --mem 1T # memory pool for all cores
#SBATCH -t 2-00:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address

##
# Bedtools merge gets rid of redundancy when you have things mapping in the same place 
###
source package b0ed0698-358b-4c9b-9d21-603ea8d6e478 # bedtools-2.31.0

source package 758be80b-33cc-495a-9adc-11882ab145b1 # samtools-1.10

file=ruz.sam # Do this for each of three ruziziensis, diploid brizantha, diploid decumbens
out=ruz


samtools view  -@16 -h -b ${file}   | samtools sort > ${out}.sorted.bam # merge requires that the data is sorted by chromosomes then position

samtools index ${out}.sorted.bam

bedtools bamtobed -i ${out}.sorted.bam > ${out}.bed

sort -k1,1 -k2,2n ${out}.bed > ${out}.sorted.bed

bedtools merge -bed -i ${out}.sorted.bed > ${out}.merged.bed # by default only merges those segments that book end or overlap you can specify -d which allows for some wiggle room if things have a d distance between them then they can still be merged. I will see how much I r
