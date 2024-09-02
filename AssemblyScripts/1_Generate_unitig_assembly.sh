#!/bin/bash
#SBATCH -p ei-medium # partition (queue)
#SBATCH -c 32
#SBATCH --mem 400G # memory pool for all cores
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address

source package 3c087633-18b1-4e77-9b08-7e68657fce66

hifi=/ei/projects/d/df141853-c5bd-4514-96f5-dbced5c97fd0/basilisks-hifi/
hic=/ei/projects/d/df141853-c5bd-4514-96f5-dbced5c97fd0/basilisks-omnic/

hifiasm -o v018_try1 -t 32 --n-hap 4 \
 --h1 ${hic}R0924-S0001_PDEV58Brach_PDEV58Brach_HGNNKDRX2_ATCACG_L001_R1.fastq.gz,${hic}R0924-S0001_PDEV58Brach_PDEV58Brach_GD5RK_ATCACG_L001_R1.fastq.gz \
 --h2 ${hic}R0924-S0001_PDEV58Brach_PDEV58Brach_HGNNKDRX2_ATCACG_L001_R2.fastq.gz,${hic}R0924-S0001_PDEV58Brach_PDEV58Brach_GD5RK_ATCACG_L001_R2.fastq.gz \
 ${hifi}cell1_demultiplex.bc1016_BAK8B_OA--bc1016_BAK8B_OA.hifi_reads.cutadapt_keep.fastq.gz \
 ${hifi}cell2_demultiplex.bc1016_BAK8B_OA--bc1016_BAK8B_OA.hifi_reads.cutadapt_keep.fastq.gz \
 ${hifi}cell3_demultiplex.bc1016_BAK8B_OA--bc1016_BAK8B_OA.hifi_reads.cutadapt_keep.fastq.gz


#Convert gfa to fasta

awk '/^S/{print ">"$2;print $3}' v018_try1.hic.p_utg.gfa > v018_try1.hic.p_utg.fa
