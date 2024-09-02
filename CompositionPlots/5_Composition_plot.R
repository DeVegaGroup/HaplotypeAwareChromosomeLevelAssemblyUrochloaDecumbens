###
# The below script has been edited from the plot_coverage() function in PafR
#NB the below was done on OOD without overlay so uses Rv3 as such some the size command and scale command are different if using Rv4 = linewidth and something else.
library(ggplot2)
library(dplyr)
library(scales)
library(stringr)

wd <-'/ei/.project-scratch/d/df141853-c5bd-4514-96f5-dbced5c97fd0/results/ManualCuration/Paper/Coverage_plots/'
chrom_len <- 'chromosome_lengths.txt'
bed <- 'urochloa.merged.chr.bed'
setwd(paste0(wd))


bed <- read.table(paste0(bed), header = T, row.names = NULL, sep= "\t")
chr <- read.table(paste0(chrom_len), header = T)

df <- left_join(bed, chr, by = 'seq_name')

colnames(df)[colnames(df) == 'qname'] <- 'Species'

df$chrname <- str_split(df$seq_name, "_", simplify = T)[,2]
df$chrname <- as.factor(df$chrname)

df$chrname <- factor(df$chrname, levels=c("1","2","3",
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



p <- ggplot() +
  geom_rect(data = df,
            aes(xmin = 0, xmax = seq_len, ymin = -2, ymax = 2),
            colour = "black", fill = "white", size = 1)


p + geom_rect(data = df, aes(xmin = tstart, xmax = tend, ymin = -0195, ymax = 1.95, fill = Species)) +
  scale_fill_manual(values = c("Urochloa brizantha" = "purple","Urochloa decumbens"="#56B4E9", "Urochloa ruziziensis" = "orange")) +
  scale_x_continuous(labels = scales::label_number_si()) + # deprecated for v4 use scales::label_number(scale_cut = cut_short_scale())
  theme_bw() +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank()) +
  facet_grid(.data[["chrname"]] ~ .)

ggsave("my_a4.pdf", device = "pdf", plot = q, height = 11.693 , width = 8.268)
