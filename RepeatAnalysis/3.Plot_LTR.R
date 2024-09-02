####Creating Coverage plots using script from pafR####

library(ggplot2)
library(dplyr)
library(stringr)
library(tidyr)

#Make
sure done before using this file
#sed -i 's/Chromosome/Chr/g' chromosome_lengths.txt > chr_lengths.txt # file of chromosome lengths from .fai

#Set working directories and get file names
wd <-'Documents/DeVegaGroup/Brachiaria/Genome_report/Repeats/EDTA/'
setwd(paste0(wd))
chrom_len <- 'chr_lengths.txt'
file <- 'lpUroDecu1.renamed.fasta.mod.EDTA.intact_CHR_LTR_ONLY.gff3'

#Read in files - one is out put from EDTA and the other is a chromosome length file (.fai)
df <- read.table(paste0(file), header = F, row.names = NULL, sep= "\t")
chr <- read.table(paste0(chrom_len), header = F)

#Add chromosome lengths to gff
gff <- left_join(df,chr, by = "V1")

#Name the columns that we will be using to make human readable
colnames(gff)[1] <- 'seqnames'
colnames(gff)[10] <- 'length'

#Chromosomes are named Chr_n remove Chr_ so is neater for presenting
gff$seqnames <- sub(".*_", "", gff$seqnames) #leaves just chromosome number not chr_
gff$seqnames <- as.factor(gff$seqnames)

#Make sure factors in coherent order
gff$seqnames <- factor(gff$seqnames, levels=c("1","2","3",
                                          "4","5","6",
                                          "7","8","9",
                                          "10","11","12",
                                          "13","14","15",
                                          "16","17","18",
                                          "19","20","21",
                                          "22","23","24",
                                          "25","26","27",
                                          "28","29","30",
                                          "31","32","33",
                                          "34","35","36"))



chromosomes <- as.list(levels(gff$seqnames))


#Function that bins data and counts number repeats by starting position in each bin designed to
#calculate for a chromosome at a time.
calc_repeat_density <-function(chromosome_number, bin){

#subset to single chromsomes
chr <- subset(gff,(gff$seqnames == chromosome_number))

#Get chromsome length
chr_length <- unique(chr$length)

#create bins (hard coded length for now)
Chr_bin <- cut(chr$V4,
               breaks = seq(from=1,
                            to = chr_length,
                            by = bin),
               include.lowest = T,
               right = F,
               labels = F)



#Make sure it is a data frame
Chr_bin <- as.data.frame(Chr_bin) # dataframe containing the bin for each site. The bins will not be evenly distrubted among sites as the bins are based on the chr_len and it may be that if you divide 200mb chromosome into 50 so 4mb each bin bin 1 may have 50 sites but bin 2 may have 67 etc.

#Add extra bin at the end for things more than the last bin
Chr_bin <- Chr_bin %>% mutate_if(is.integer, ~replace(., is.na(.), max(Chr_bin, na.rm=T) +1)) # unlikely that the chromosome length is divisble by 50 the remainder sites are assigned NA therefore this replaces NAs with the (maximum bin value +1) so creates a bin at the end

#Add bin count data to the chromosome dataframe
gff_bin <- bind_cols(chr, Chr_bin) # combine data and bin so now V5 is Chr_bin
  df <- gff_bin %>%
  group_by(Chr_bin) %>%
  mutate(count = n())

#Readjust coordinated to reflect the genomic position not the bin number
df$coords <- df$Chr_bin*bin

#Ensure it is a dataframe
final_df<- as.data.frame(df)
}

#Create the dataframe with count data for each chromosome by feeding the function a list of chromosomes
# numbers and providing bin size
combined_df <- do.call(rbind, lapply(chromosomes, function(fn) calc_repeat_density(fn, 1000000)))



combined_df$seqnames <- factor(combined_df$seqnames, levels=c("1","5","9",
                                              "13","17","21",
                                              "25","29","33",
                                              "2","6","10",
                                              "14","18","22",
                                              "26","30","34",
                                              "3","7","11",
                                              "15","19","23",
                                              "27","31","35",
                                              "4","8","12",
                                              "16","20","24",
                                              "28","32","36"))

#Create painted chromosomes where repeats represented as heat maps with high number being red and low being blue/purple
#x value picked at random as needed to plot but doesnt mean anything just to anchor plots
#This plot does not work at high resoltuion ie low bin sizes best 1e6
ggplot(combined_df, aes(x =0.5, y =coords, fill= count)) +
  geom_tile() +
  scale_y_reverse() +
  theme_classic()+
  facet_wrap( ~seqnames, nrow=4, ncol = 9) +
  scale_fill_gradientn(colours = c('#801638','#027878','#FDB632','#F37338','#C22326'))+
  labs(x="", y ="Position along chromosome", fill = '# Repeats') +
  theme(axis.text.x = element_blank(),
        axis.ticks = element_blank(),
        axis.line.x = element_blank())
