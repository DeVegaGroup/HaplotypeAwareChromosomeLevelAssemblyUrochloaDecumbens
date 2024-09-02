#SBATCH -p ei-largemem # partition (queue)
#SBATCH -c 16
#SBATCH --mem 640G # memory pool for all cores
#SBATCH -t 2-00:00 # time (D-HH:MM)
#SBATCH -o slurm.%N.%j.out # STDOUT
#SBATCH -e slurm.%N.%j.err # STDERR
#SBATCH --mail-type=end,fail # notifications for job done & fail
#SBATCH --mail-user=camilla.ryan@earlham.ac.uk # send-to address


source bwa-0.7.17

reference=data/ref.fa

HiCR1=data/HiC_R1.fastq.gz

HiCR2=data/HiC_R2.fastq.gz

bwa mem -5SP -T0 -t 16  $reference $HiCR1 $HiCR2 -o mapped_omnic.sam

samtools view -@ 8 -b -h mapped_omnic.sam | samtools sort -m 32G > mapped_sorted_omnic.bam       
