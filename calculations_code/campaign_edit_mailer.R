# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_mailer <- read_csv("~/Desktop/stat_proj/raw_data/campaign_mailer.csv")

# check column names 
colnames(campaign_mailer)

# slim down columns to leave only the required 
colnames(campaign_mailer)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

mailer_drop <- campaign_mailer[keeps]
colnames(mailer_drop)

# rename columns 
library(dplyr)

mailer_drop <- mailer_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(mailer_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(mailer_drop$committee_id)

# calculate mailer total 
calc_mailer <- data.frame()

for(i in df_list){
  df1 <- subset(mailer_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_mailer <- rbind(calc_mailer, df2)
}

# rename total column 
calc_mailer <- calc_mailer %>% 
  rename(mailer = total)
colnames(calc_mailer)

# export df to csv 
write_csv(calc_mailer, "calc_mailer.csv")
