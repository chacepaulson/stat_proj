# import data set 
library(readr)
winner_calc <- read_csv("~/Desktop/stat_proj/coded_data/winner_calc.csv", 
                        col_types = cols(X1 = col_skip()))
loser_calc <- read_csv("~/Desktop/stat_proj/coded_data/loser_calc.csv", 
                       col_types = cols(X1 = col_skip()))

# calculate percentages for each spending type 
colnames(winner_calc2)

winner_calc2 <- winner_calc

winner_calc2$per_advertise <- winner_calc2$advertise / winner_calc2$total
winner_calc2$per_poll <- winner_calc2$poll / winner_calc2$total
winner_calc2$per_research <- winner_calc2$research / winner_calc2$total
winner_calc2$per_consulting <- winner_calc2$consulting / winner_calc2$total
winner_calc2$per_fundraise <- winner_calc2$fundraise / winner_calc2$total
winner_calc2$per_pay <- winner_calc2$pay / winner_calc2$total
winner_calc2$per_materials <- winner_calc2$materials / winner_calc2$total
winner_calc2$per_travel <- winner_calc2$travel / winner_calc2$total
winner_calc2$per_event <- winner_calc2$event / winner_calc2$total
winner_calc2$per_mail <- winner_calc2$mail / winner_calc2$total
winner_calc2$per_radio <- winner_calc2$radio / winner_calc2$total
winner_calc2$per_television <- winner_calc2$television / winner_calc2$total
winner_calc2$per_newspaper <- winner_calc2$newspaper / winner_calc2$total
winner_calc2$per_smedia <- winner_calc2$smedia / winner_calc2$total
winner_calc2$per_website <- winner_calc2$website / winner_calc2$total

loser_calc2 <- loser_calc

loser_calc2$per_advertise <- loser_calc2$advertise / loser_calc2$total
loser_calc2$per_poll <- loser_calc2$poll / loser_calc2$total
loser_calc2$per_research <- loser_calc2$research / loser_calc2$total
loser_calc2$per_consulting <- loser_calc2$consulting / loser_calc2$total
loser_calc2$per_fundraise <- loser_calc2$fundraise / loser_calc2$total
loser_calc2$per_pay <- loser_calc2$pay / loser_calc2$total
loser_calc2$per_materials <- loser_calc2$materials / loser_calc2$total
loser_calc2$per_travel <- loser_calc2$travel / loser_calc2$total
loser_calc2$per_event <- loser_calc2$event / loser_calc2$total
loser_calc2$per_mail <- loser_calc2$mail / loser_calc2$total
loser_calc2$per_radio <- loser_calc2$radio / loser_calc2$total
loser_calc2$per_television <- loser_calc2$television / loser_calc2$total
loser_calc2$per_newspaper <- loser_calc2$newspaper / loser_calc2$total
loser_calc2$per_smedia <- loser_calc2$smedia / loser_calc2$total
loser_calc2$per_website <- loser_calc2$website / loser_calc2$total

# export to csv 
write.csv(winner_calc2, "winner_calc2.csv")
write.csv(loser_calc2, "loser_calc2.csv")
