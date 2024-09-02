####
# Script that takes parsed output from BUSCO (full_table.tsv) and produces a bar plot of
# how many times each protein detected. It is important to know the ploidy
# for this to be an effective analysis otherwise slightly redundant - need to know
# if things are meant to occur 2x or 4x etc or if it is an artefact of sequencing.
# Also need to bear in mind whether haploid assembly in which case anything that occurs
# more than 1x is sequencing artefact or possibly real duplication.
#
# The following line must be run on the command line to get the data in the correct format:
# cat full_table.tsv | cut -f 1 | sort | uniq -c | sort -nr | grep -v '#' > busco_results_hic.tsv
####

library("ggplot2")
library("dplyr")

wd <- "/Users/ryanc/Documents/DeVegaGroup/Brachiaria/Genome_report/BUSCO/all/"
setwd(paste0(wd))
file <- "all_busco_results.tsv"
out<- "all_busco"

df <- read.table(paste0(file))
df$V1 <- as.factor(df$V1)

plot <- ggplot(df, aes(x = V1)) + stat_count() +
  xlab("Number of BUSCO gene copies found") +
  ylab("Count") +

scale_y_continuous(expand = c(0, 0)) +
  theme_classic()


ggsave(paste0(out,".png"), plot, width = 20, height = 20, units = "cm")

tab <- table(df$V1)
 write.csv(file = paste0(out,".csv"), tab, row.names = F)
