# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_materials <- read_csv("~/Desktop/stat_proj/raw_data/campaign_materials.csv")

# check column names 
colnames(campaign_materials)

# slim down columns to leave only the required 
colnames(campaign_materials)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

materials_drop <- campaign_materials[keeps]
colnames(materials_drop)

# rename columns 
library(dplyr)

materials_drop <- materials_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(materials_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(materials_drop$committee_id)

# calculate materials total 
calc_materials <- data.frame()

for(i in df_list){
  df1 <- subset(materials_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_materials <- rbind(calc_materials, df2)
}

# rename total column 
calc_materials <- calc_materials %>% 
  rename(materials = total)
colnames(calc_materials)

# export df to csv 
write_csv(calc_materials, "calc_materials.csv")
