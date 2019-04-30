# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_television <- read_csv("~/Desktop/stat_proj/raw_data/campaign_television.csv")

# check column names 
colnames(campaign_television)

# slim down columns to leave only the required 
colnames(campaign_television)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

television_drop <- campaign_television[keeps]
colnames(television_drop)

# rename columns 
library(dplyr)

television_drop <- television_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(television_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(television_drop$committee_id)

# calculate television total 
calc_television <- data.frame()

for(i in df_list){
  df1 <- subset(television_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_television <- rbind(calc_television, df2)
}

# rename total column 
calc_television <- calc_television %>% 
  rename(television = total)
colnames(calc_television)

# export df to csv 
write_csv(calc_television, "calc_television.csv")
