# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_consulting <- read_csv("~/Desktop/stat_proj/raw_data/campaign_consulting.csv")

# check column names 
colnames(campaign_consulting)

# slim down columns to leave only the required 
colnames(campaign_consulting)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

consulting_drop <- campaign_consulting[keeps]
colnames(consulting_drop)

# rename columns 
library(dplyr)

consulting_drop <- consulting_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(consulting_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(consulting_drop$committee_id)

# calculate consulting total 
calc_consulting <- data.frame()

for(i in df_list){
  df1 <- subset(consulting_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_consulting <- rbind(calc_consulting, df2)
}

# rename total column 
calc_consulting <- calc_consulting %>% 
  rename(consulting = total)
colnames(calc_consulting)

# export df to csv 
write_csv(calc_consulting, "calc_consulting.csv")
