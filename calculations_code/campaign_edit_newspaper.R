# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_newspaper <- read_csv("~/Desktop/stat_proj/raw_data/campaign_newspaper.csv")

# check column names 
colnames(campaign_newspaper)

# slim down columns to leave only the required 
colnames(campaign_newspaper)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

newspaper_drop <- campaign_newspaper[keeps]
colnames(newspaper_drop)

# rename columns 
library(dplyr)

newspaper_drop <- newspaper_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(newspaper_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(newspaper_drop$committee_id)

# calculate newspaper total 
calc_newspaper <- data.frame()

for(i in df_list){
  df1 <- subset(newspaper_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_newspaper <- rbind(calc_newspaper, df2)
}

# rename total column 
calc_newspaper <- calc_newspaper %>% 
  rename(newspaper = total)
colnames(calc_newspaper)

# export df to csv 
write_csv(calc_newspaper, "calc_newspaper.csv")
