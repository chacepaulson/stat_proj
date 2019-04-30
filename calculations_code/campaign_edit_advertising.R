# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_advertising <- read_csv("~/Desktop/stat_proj/raw_data/campaign_advertising.csv")

# check column names 
colnames(campaign_advertising)

# slim down columns to leave only the required 
colnames(campaign_advertising)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

advertising_drop <- campaign_advertising[keeps]
colnames(advertising_drop)

# rename columns 
library(dplyr)

advertising_drop <- advertising_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(advertising_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(advertising_drop$committee_id)

# calculate advertising total 
calc_advertising <- data.frame()

for(i in df_list){
  df1 <- subset(advertising_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_advertising <- rbind(calc_advertising, df2)
}

# rename total column 
calc_advertising <- calc_advertising %>% 
  rename(advertising = total)
colnames(calc_advertising)

# export df to csv 
write_csv(calc_advertising, "calc_advertising.csv")
