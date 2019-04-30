# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_dmail <- read_csv("~/Desktop/stat_proj/raw_data/campaign_dmail.csv")

# check column names 
colnames(campaign_dmail)

# slim down columns to leave only the required 
colnames(campaign_dmail)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

dmail_drop <- campaign_dmail[keeps]
colnames(dmail_drop)

# rename columns 
library(dplyr)

dmail_drop <- dmail_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(dmail_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(dmail_drop$committee_id)

# calculate dmail total 
calc_dmail <- data.frame()

for(i in df_list){
  df1 <- subset(dmail_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_dmail <- rbind(calc_dmail, df2)
}

# rename total column 
calc_dmail <- calc_dmail %>% 
  rename(dmail = total)
colnames(calc_dmail)

# export df to csv 
write_csv(calc_dmail, "calc_dmail.csv")
