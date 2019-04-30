# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_travel <- read_csv("~/Desktop/stat_proj/raw_data/campaign_travel.csv")

# check column names 
colnames(campaign_travel)

# slim down columns to leave only the required 
colnames(campaign_travel)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

travel_drop <- campaign_travel[keeps]
colnames(travel_drop)

# rename columns 
library(dplyr)

travel_drop <- travel_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(travel_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(travel_drop$committee_id)

# calculate travel total 
calc_travel <- data.frame()

for(i in df_list){
  df1 <- subset(travel_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_travel <- rbind(calc_travel, df2)
}

# rename total column 
calc_travel <- calc_travel %>% 
  rename(travel = total)
colnames(calc_travel)

# export df to csv 
write_csv(calc_travel, "calc_travel.csv")
