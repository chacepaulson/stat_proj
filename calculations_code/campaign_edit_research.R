# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_research <- read_csv("~/Desktop/stat_proj/raw_data/campaign_research.csv")

# check column names 
colnames(campaign_research)

# slim down columns to leave only the required 
colnames(campaign_research)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

research_drop <- campaign_research[keeps]
colnames(research_drop)

# rename columns 
library(dplyr)

research_drop <- research_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(research_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(research_drop$committee_id)

# calculate research total 
calc_research <- data.frame()

for(i in df_list){
  df1 <- subset(research_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_research <- rbind(calc_research, df2)
}

# rename total column 
calc_research <- calc_research %>% 
  rename(research = total)
colnames(calc_research)

# export df to csv 
write_csv(calc_research, "calc_research.csv")
