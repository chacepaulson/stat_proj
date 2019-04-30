# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_fgroup <- read_csv("~/Desktop/stat_proj/raw_data/campaign_fgroup.csv")

# check column names 
colnames(campaign_fgroup)

# slim down columns to leave only the required 
colnames(campaign_fgroup)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

fgroup_drop <- campaign_fgroup[keeps]
colnames(fgroup_drop)

# rename columns 
library(dplyr)

fgroup_drop <- fgroup_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(fgroup_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(fgroup_drop$committee_id)

# calculate fgroup total 
calc_fgroup <- data.frame()

for(i in df_list){
  df1 <- subset(fgroup_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_fgroup <- rbind(calc_fgroup, df2)
}

# rename total column 
calc_fgroup <- calc_fgroup %>% 
  rename(fgroup = total)
colnames(calc_fgroup)

# export df to csv 
write_csv(calc_fgroup, "calc_fgroup.csv")
