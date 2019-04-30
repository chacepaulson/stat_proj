# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_event <- read_csv("~/Desktop/stat_proj/raw_data/campaign_event.csv")

# check column names 
colnames(campaign_event)

# slim down columns to leave only the required 
colnames(campaign_event)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

event_drop <- campaign_event[keeps]
colnames(event_drop)

# rename columns 
library(dplyr)

event_drop <- event_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(event_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(event_drop$committee_id)

# calculate event total 
calc_event <- data.frame()

for(i in df_list){
  df1 <- subset(event_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_event <- rbind(calc_event, df2)
}

# rename total column 
calc_event <- calc_event %>% 
  rename(event = total)
colnames(calc_event)

# export df to csv 
write_csv(calc_event, "calc_event.csv")
