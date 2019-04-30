# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_radio <- read_csv("~/Desktop/stat_proj/raw_data/campaign_radio.csv")

# check column names 
colnames(campaign_radio)

# slim down columns to leave only the required 
colnames(campaign_radio)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

radio_drop <- campaign_radio[keeps]
colnames(radio_drop)

# rename columns 
library(dplyr)

radio_drop <- radio_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(radio_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(radio_drop$committee_id)

# calculate radio total 
calc_radio <- data.frame()

for(i in df_list){
  df1 <- subset(radio_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_radio <- rbind(calc_radio, df2)
}

# rename total column 
calc_radio <- calc_radio %>% 
  rename(radio = total)
colnames(calc_radio)

# export df to csv 
write_csv(calc_radio, "calc_radio.csv")
