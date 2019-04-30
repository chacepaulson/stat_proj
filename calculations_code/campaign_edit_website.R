# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_website <- read_csv("~/Desktop/stat_proj/raw_data/campaign_website.csv")

# check column names 
colnames(campaign_website)

# slim down columns to leave only the required 
colnames(campaign_website)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

website_drop <- campaign_website[keeps]
colnames(website_drop)

# rename columns 
library(dplyr)

website_drop <- website_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(website_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(website_drop$committee_id)

# calculate website total 
calc_website <- data.frame()

for(i in df_list){
  df1 <- subset(website_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_website <- rbind(calc_website, df2)
}

# rename total column 
calc_website <- calc_website %>% 
  rename(website = total)
colnames(calc_website)

# export df to csv 
write_csv(calc_website, "calc_website.csv")
