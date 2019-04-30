# import data
library(readr)
candidates <- read_csv("~/Desktop/stat_proj/raw_data/candidates.csv")
results <- read_csv("~/Desktop/stat_proj/raw_data/results.csv")

# check columns and slim down 
colnames(results)

winner <- results
keeps <- c("state_abrev", "district_num", "region", "hold_flip",
           "winner", "win_id", "win_per", "lose_per", "delta")
winner <- winner[keeps]

loser <- results
keeps <- c("state_abrev", "district_num", "region", "hold_flip",
           "loser", "lose_id", "lose_per", "win_per", "delta")
loser <- loser[keeps]

colnames(candidates)
keeps <- c("name", "party", "state", "district", "incumbent_challenge",
           "candidate_id")
candidates <- candidates[keeps]

# rename columns
colnames(candidates)
colnames(winner)
colnames(loser)

winner <- winner %>% 
  rename(state = state_abrev, 
         district = district_num, 
         candidate = winner, 
         candidate_id = win_id)

loser <- loser %>% 
  rename(state = state_abrev, 
         district = district_num, 
         candidate = loser, 
         candidate_id = lose_id)

candidates <- candidates %>% 
  rename(candidate = name)

# merge data 
merge_winner <- merge(candidates, winner, by = "candidate_id")
merge_loser <- merge(candidates, loser, by = "candidate_id")

# write csvs 
write.csv(merge_winner, "winner.csv")
write.csv(merge_loser, "loser.csv")

