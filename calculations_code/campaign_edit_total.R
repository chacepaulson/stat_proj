# import data 
library(readr)

election_totals1 <- read_csv("~/Desktop/stat_proj/raw_data/election_totals1.csv")
election_totals2 <- read_csv("~/Desktop/stat_proj/raw_data/election_totals2.csv")
election_totals3 <- read_csv("~/Desktop/stat_proj/raw_data/election_totals3.csv")
election_totals4 <- read_csv("~/Desktop/stat_proj/raw_data/election_totals4.csv")

# merge data sets
elections <- rbind(election_totals1, election_totals2, 
                   election_totals3, election_totals4)

# check that all rows transferred 
nrow(election_totals1) + nrow(election_totals2) + nrow(election_totals3) +
  nrow(election_totals4)
nrow(elections)

# cut down rows to keep only those necessary
colnames(elections)
keeps <- c("committee_id", "disbursement_amount")
election_drop <- elections[keeps]
colnames(election_drop)

# rename columns 
library(dplyr)

election_drop <- election_drop %>% 
  rename(dis_amount = disbursement_amount)
colnames(election_drop)

# Calculate Totals --------------------------------------------------------

# initialize 
df_list <- unique(election_drop$committee_id)

# calculate total 
calc_total <- data.frame()
for(i in df_list){
  df1 <- subset(election_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_total <- rbind(calc_total, df2)
}
colnames(calc_total)
nrow(calc_total)

# export to csv 
write.csv(calc_total, "calc_total.csv")


