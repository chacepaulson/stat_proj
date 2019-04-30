# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_postage <- read_csv("~/Desktop/stat_proj/raw_data/campaign_postage.csv")

# check column names 
colnames(campaign_postage)

# slim down columns to leave only the required 
colnames(campaign_postage)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

postage_drop <- campaign_postage[keeps]
colnames(postage_drop)

# rename columns 
library(dplyr)

postage_drop <- postage_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(postage_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(postage_drop$committee_id)

# calculate postage total 
calc_postage <- data.frame()

for(i in df_list){
  df1 <- subset(postage_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_postage <- rbind(calc_postage, df2)
}

# rename total column 
calc_postage <- calc_postage %>% 
  rename(postage = total)
colnames(calc_postage)

# export df to csv 
write_csv(calc_postage, "calc_postage.csv")
