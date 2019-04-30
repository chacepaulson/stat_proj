# import data sets
library(readr)
calc_combine <- read_csv("~/Desktop/stat_proj/coded_data/calc_combine.csv", 
                         col_types = cols(X1 = col_skip()))
committees <- read_csv("~/Desktop/stat_proj/raw_data/committees2.csv")
winner <- read_csv("~/Desktop/stat_proj/coded_data/winner.csv", 
                   col_types = cols(X1 = col_skip()))
loser <- read_csv("~/Desktop/stat_proj/coded_data/loser.csv", 
                  col_types = cols(X1 = col_skip()))

# slim down committees file 
colnames(committees)
keeps <- c("name", "committee_id", "candidate_ids")
committees <- committees[keeps]

colnames(winner)
keeps <- c("candidate_id", "candidate.x", "party", "state.x", "district.x",
           "incumbent_challenge", "region", "hold_flip", "win_per", "lose_per",
           "delta")
winner <- winner[keeps]

colnames(loser)
keeps <- c("candidate_id", "candidate.x", "party", "state.x", "district.x",
           "incumbent_challenge", "region", "hold_flip", "win_per", "lose_per",
           "delta")
loser <- loser[keeps]

# rename columns 
library(dplyr)
committees <- committees %>% 
  rename(committee_name = name, 
         candidate_id = candidate_ids)

winner <- winner %>% 
  rename(candidate_name = candidate.x)

loser <- loser %>% 
  rename(candidate_name = candidate.x)

colnames(calc_combine)
colnames(committees)
colnames(winner)
colnames(loser)

# merge data sets
merge1 <- NA
merge1 <- merge(winner, committees, by = "candidate_id", all.x = TRUE)

merge2 <- NA
merge2 <- merge(loser, committees, by = "candidate_id", all.x = TRUE)


winner_calc <- merge(merge1, calc_combine, by = "committee_id")
loser_calc <- merge(merge2, calc_combine, by = "committee_id")

# alter data frames before export 
colnames(winner_calc)
colnames(loser_calc)

winner_calc <- winner_calc %>% 
  rename(state = state.x,
         district = district.x)

loser_calc <- loser_calc %>% 
  rename(state = state.x,
         district = district.x)

keeps <- c("committee_name", "committee_id", "candidate_name", "candidate_id",
           "party", "state", "district", "region", "incumbent_challenge", "hold_flip",
           "win_per", "lose_per", "delta", "total", "advertise", "poll", "research", 
           "consulting", "fundraise", "pay", "materials", "travel", "event", "mail", 
           "radio", "television", "newspaper", "smedia", "website")
winner_calc <- winner_calc[keeps]
loser_calc <- loser_calc[keeps]

# export to csv
write.csv(winner_calc, "winner_calc.csv")
write.csv(loser_calc, "loser_calc.csv")
