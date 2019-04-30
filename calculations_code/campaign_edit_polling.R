# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_polling <- read_csv("~/Desktop/stat_proj/raw_data/campaign_polling.csv")

# check column names 
colnames(campaign_polling)

# slim down columns to leave only the required 
colnames(campaign_polling)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

polling_drop <- campaign_polling[keeps]
colnames(polling_drop)

# rename columns 
library(dplyr)

polling_drop <- polling_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(polling_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(polling_drop$committee_id)

# calculate polling total 
calc_polling <- data.frame()

for(i in df_list){
  df1 <- subset(polling_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_polling <- rbind(calc_polling, df2)
}

# rename total column 
calc_polling <- calc_polling %>% 
  rename(polling = total)
colnames(calc_polling)

# export df to csv 
write_csv(calc_polling, "calc_polling.csv")
