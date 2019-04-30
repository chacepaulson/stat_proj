# Import and Edit Data ----------------------------------------------------

# import data 
library(readr)
campaign_salary <- read_csv("~/Desktop/stat_proj/raw_data/campaign_salary.csv")

# check column names 
colnames(campaign_salary)

# slim down columns to leave only the required 
colnames(campaign_salary)
keeps <- c("committee_id", "committee_name", "fec_election_type_desc", 
           "disbursement_date","recipient_name","disbursement_description", "disbursement_amount",
           "disbursement_purpose_category")

salary_drop <- campaign_salary[keeps]
colnames(salary_drop)

# rename columns 
library(dplyr)

salary_drop <- salary_drop %>% 
  rename(election_type = fec_election_type_desc,
         dis_date = disbursement_date,
         dis_descrip = disbursement_description,
         dis_amount = disbursement_amount, 
         dis_category = disbursement_purpose_category)
colnames(salary_drop)

# Calculations ------------------------------------------------------------

# initialize 
df_list <- unique(salary_drop$committee_id)

# calculate salary total 
calc_salary <- data.frame()

for(i in df_list){
  df1 <- subset(salary_drop, committee_id == i)
  total <- sum(df1$dis_amount)
  df2 <- data.frame("committee_id" = df1$committee_id[1], total)
  calc_salary <- rbind(calc_salary, df2)
}

# rename total column 
calc_salary <- calc_salary %>% 
  rename(salary = total)
colnames(calc_salary)

# export df to csv 
write_csv(calc_salary, "calc_salary.csv")
