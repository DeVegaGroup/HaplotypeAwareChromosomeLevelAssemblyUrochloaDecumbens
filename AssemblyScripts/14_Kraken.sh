#!/bin/bash
#SBATCH -p ei-largemem # queue
#SBATCH -N 1 # number of nodes
#SBATCH -c 4 # number of cores
#SBATCH --mem 800G # memory pool for all cores
#SBATCH -t 0-12:00 # time (D-HH:MM)
#SBATCH -J kraken2_reads
#SBATCH -o %N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --constraint=intel


source kraken2-2.0.7
source krona-2.7.1_CBG
assembly=/ei/.project-scratch/d/df141853-c5bd-4514-96f5-dbced5c97fd0/results/ManualCuration/lpUroDecu1.fasta
database=refseq_2019




kraken2 --db $database --classified-out classified_hifihic-u.fa --unclassified-out unclassified_hifihic-u.fa --output kraken_hifihic-u.out $assembly


ktImportTaxonomy -o hifihic-u.krona.html -q 2 -t 3 -s 4 kraken_hifihic-u.out


#Use the kronaplot to get a list of non target species - i.e. non viridiplantae that are likely contaminants.
