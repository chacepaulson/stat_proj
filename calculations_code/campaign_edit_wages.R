# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_wages <- read_csv("~/Desktop/stat_proj/raw_data/campaign_wages.csv")

# check column names 
colnames(campaign_wages)

# slim down columns to leave only the required 
colnames(campaign_wages)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

wages_drop <- campaign_wages[keeps]
colnames(wages_drop)

# rename columns 
library(dplyr)

wages_drop <- wages_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(wages_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(wages_drop$committee_id)

# calculate wages total 
calc_wages <- data.frame()

for(i in df_list){
  df1 <- subset(wages_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_wages <- rbind(calc_wages, df2)
}

# rename total column 
calc_wages <- calc_wages %>% 
  rename(wages = total)
colnames(calc_wages)

# export df to csv 
write_csv(calc_wages, "calc_wages.csv")
