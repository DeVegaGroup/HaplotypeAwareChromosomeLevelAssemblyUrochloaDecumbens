#!/bin/bash
#SBATCH -p ei-medium # partition (queue)
#SBATCH -c 8
#SBATCH --mem 200G # memory pool for all cores
#SBATCH -t 3-00:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address

REF=$1

source bwa-0.7.17

source pairtools-0.3.0

source samtools-1.5

source gcc-6.2.0

samtools faidx ${REF}

cut -f1,2 ${REF}.fai > ${REF}.fai.genome

bwa index ${REF}

bwa mem -5SP -T0 -t32 ${REF} \

<(zcat R0924-S0001_PDEV58Brach_PDEV58Brach_GD5RK_ATCACG_L001_R1.fastq.gz R0924-S0001_PDEV58Brach_PDEV58Brach_HGNNKDRX2_ATCACG_L001_R1.fastq.gz) \

<(zcat R0924-S0001_PDEV58Brach_PDEV58Brach_GD5RK_ATCACG_L001_R2.fastq.gz R0924-S0001_PDEV58Brach_PDEV58Brach_HGNNKDRX2_ATCACG_L001_R2.fastq.gz) | \

samblaster | samtools view -S -h -b -F 2316 -@8 | samtools sort -n -@8 -o ${REF}.1.bam
