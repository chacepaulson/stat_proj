# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_fundraiser <- read_csv("~/Desktop/stat_proj/raw_data/campaign_fundraiser.csv")

# check column names 
colnames(campaign_fundraiser)

# slim down columns to leave only the required 
colnames(campaign_fundraiser)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

fundraiser_drop <- campaign_fundraiser[keeps]
colnames(fundraiser_drop)

# rename columns 
library(dplyr)

fundraiser_drop <- fundraiser_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(fundraiser_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(fundraiser_drop$committee_id)

# calculate fundraiser total 
calc_fundraiser <- data.frame()

for(i in df_list){
  df1 <- subset(fundraiser_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_fundraiser <- rbind(calc_fundraiser, df2)
}

# rename total column 
calc_fundraiser <- calc_fundraiser %>% 
  rename(fundraiser = total)
colnames(calc_fundraiser)

# export df to csv 
write_csv(calc_fundraiser, "calc_fundraiser.csv")
