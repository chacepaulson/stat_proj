# Importing Data ----------------------------------------------------------

# import data 
library(readr)
winner_calc <- read_csv("~/Desktop/stat_proj/coded_data/winner_calc2.csv", 
                         col_types = cols(X1 = col_skip()))
loser_calc <- read_csv("~/Desktop/stat_proj/coded_data/loser_calc2.csv", 
                        col_types = cols(X1 = col_skip()))

# recategorize variables to ensure numeric
winner_calc$delta <- as.double(winner_calc$delta)
loser_calc$delta <- as.double(loser_calc$delta)

# load packages
library(tidyverse)
library(reshape2)
library(ggplot2)
library(dplyr)
library(usmap)
library(xtable)

# Subset Data -------------------------------------------------------------

# by political party 
unique(winner_calc$party)
winner_rep <- subset(winner_calc, party == "REP")
winner_dem <- subset(winner_calc, party == "DEM")

loser_rep <- subset(loser_calc, party == "REP")
loser_dem <- subset(loser_calc, party == "DEM")

# by region
unique(winner_calc$region)
winner_south <- subset(winner_calc, region == "south")
winner_west <- subset(winner_calc, region == "west")
winner_midwest <- subset(winner_calc, region == "midwest")
winner_northeast <- subset(winner_calc, region == "northeast")

loser_south <- subset(loser_calc, region == "south")
loser_west <- subset(loser_calc, region == "west")
loser_midwest <- subset(loser_calc, region == "midwest")
loser_northeast <- subset(loser_calc, region == "northeast")

# by hold flip status
unique(winner_calc$hold_flip)
winner_dem_pickup <- subset(winner_calc, hold_flip == "Dem Pickup")
winner_dem_hold <- subset(winner_calc, hold_flip == "Dem Hold")
winner_gop_pickup <- subset(winner_calc, hold_flip == "GOP Pickup")
winner_gop_hold <- subset(winner_calc, hold_flip == "GOP Hold")

loser_dem_pickup <- subset(loser_calc, hold_flip == "Dem Pickup")
loser_dem_hold <- subset(loser_calc, hold_flip == "Dem Hold")
loser_gop_pickup <- subset(loser_calc, hold_flip == "GOP Pickup")
loser_gop_hold <- subset(loser_calc, hold_flip == "GOP Hold")

# Calculating Means -------------------------------------------------------

# A. mean spending total --------------------------------------------------

mean_spending_total <- data.frame(winner = mean(winner_calc$total, na.rm = TRUE),
                                  loser = mean(loser_calc$total, na.rm = TRUE))


# B. mean spending party --------------------------------------------------

mean_spending_party <- data.frame(party = c("DEM", "REP"),
                                  winner = c(mean(winner_dem$total, na.rm = TRUE),
                                             mean(winner_rep$total, na.rm = TRUE)),
                                  loser = c(mean(loser_dem$total, na.rm = TRUE),
                                            mean(loser_rep$total, na.rm = TRUE)))

# C. mean spending hold flip ----------------------------------------------

mean_spending_hold_flip <- data.frame(hold_flip = c("dem_pickup", "dem_hold", "gop_pickup", "gop_hold"),
                                   winner = c(mean(winner_dem_pickup$total, na.rm = TRUE),
                                              mean(winner_dem_hold$total, na.rm = TRUE),
                                              mean(winner_gop_pickup$total, na.rm = TRUE),
                                              mean(winner_gop_hold$total, na.rm = TRUE)),
                                   loser = c(mean(loser_dem_pickup$total, na.rm = TRUE),
                                             mean(loser_dem_hold$total, na.rm = TRUE),
                                             mean(loser_gop_pickup$total, na.rm = TRUE),
                                             mean(loser_gop_hold$total, na.rm = TRUE)))

# D. mean spending region -------------------------------------------------

mean_spending_region <- data.frame(region = c("south", "west", "midwest", "northeast"),
                                  winner = c(mean(winner_south$total, na.rm = TRUE),
                                             mean(winner_west$total, na.rm = TRUE),
                                             mean(winner_midwest$total, na.rm = TRUE),
                                             mean(winner_northeast$total, na.rm = TRUE)),
                                  loser = c(mean(loser_south$total, na.rm = TRUE),
                                             mean(loser_west$total, na.rm = TRUE),
                                             mean(loser_midwest$total, na.rm = TRUE),
                                             mean(loser_northeast$total, na.rm = TRUE)))

# F. mean spending percent ------------------------------------------------

colnames(winner_calc)
mean_spending_per <- data.frame(category = c("advertise", "poll", 
                                                    "research", "consulting",
                                                    "fundraise", "pay", 
                                                    "materials", "travel",
                                                    "event", "mail", 
                                                    "radio", "television", 
                                                    "newspaper", "smedia", 
                                                    "website"), 
                                       winner_mean = c(mean(winner_calc$per_advertise, na.rm = TRUE),
                                                mean(winner_calc$per_poll, na.rm = TRUE),
                                                mean(winner_calc$per_research, na.rm = TRUE),
                                                mean(winner_calc$per_consulting, na.rm = TRUE),
                                                mean(winner_calc$per_fundraise, na.rm = TRUE),
                                                mean(winner_calc$per_pay, na.rm = TRUE),
                                                mean(winner_calc$per_materials, na.rm = TRUE),
                                                mean(winner_calc$per_travel, na.rm = TRUE),
                                                mean(winner_calc$per_event, na.rm = TRUE),
                                                mean(winner_calc$per_mail, na.rm = TRUE),
                                                mean(winner_calc$per_radio, na.rm = TRUE),
                                                mean(winner_calc$per_television, na.rm = TRUE),
                                                mean(winner_calc$per_newspaper, na.rm = TRUE),
                                                mean(winner_calc$per_smedia, na.rm = TRUE),
                                                mean(winner_calc$per_website, na.rm = TRUE)),
                                loser_mean = c(mean(loser_calc$per_advertise, na.rm = TRUE),
                                                mean(loser_calc$per_poll, na.rm = TRUE),
                                                mean(loser_calc$per_research, na.rm = TRUE),
                                                mean(loser_calc$per_consulting, na.rm = TRUE),
                                                mean(loser_calc$per_fundraise, na.rm = TRUE),
                                                mean(loser_calc$per_pay, na.rm = TRUE),
                                                mean(loser_calc$per_materials, na.rm = TRUE),
                                                mean(loser_calc$per_travel, na.rm = TRUE),
                                                mean(loser_calc$per_event, na.rm = TRUE),
                                                mean(loser_calc$per_mail, na.rm = TRUE),
                                                mean(loser_calc$per_radio, na.rm = TRUE),
                                                mean(loser_calc$per_television, na.rm = TRUE),
                                                mean(loser_calc$per_newspaper, na.rm = TRUE),
                                                mean(loser_calc$per_smedia, na.rm = TRUE),
                                                mean(loser_calc$per_website, na.rm = TRUE)))

# F. mean spending amount -------------------------------------------------

colnames(winner_calc)
mean_spending_amount <- data.frame(category = c("advertise", "poll", 
                                             "research", "consulting",
                                             "fundraise", "pay", 
                                             "materials", "travel",
                                             "event", "mail", 
                                             "radio", "television", 
                                             "newspaper", "smedia", 
                                             "website"), 
                                winner_mean = c(mean(winner_calc$advertise, na.rm = TRUE),
                                                mean(winner_calc$poll, na.rm = TRUE),
                                                mean(winner_calc$research, na.rm = TRUE),
                                                mean(winner_calc$consulting, na.rm = TRUE),
                                                mean(winner_calc$fundraise, na.rm = TRUE),
                                                mean(winner_calc$pay, na.rm = TRUE),
                                                mean(winner_calc$materials, na.rm = TRUE),
                                                mean(winner_calc$travel, na.rm = TRUE),
                                                mean(winner_calc$event, na.rm = TRUE),
                                                mean(winner_calc$mail, na.rm = TRUE),
                                                mean(winner_calc$radio, na.rm = TRUE),
                                                mean(winner_calc$television, na.rm = TRUE),
                                                mean(winner_calc$newspaper, na.rm = TRUE),
                                                mean(winner_calc$smedia, na.rm = TRUE),
                                                mean(winner_calc$website, na.rm = TRUE)),
                                loser_mean = c(mean(loser_calc$advertise, na.rm = TRUE),
                                               mean(loser_calc$poll, na.rm = TRUE),
                                               mean(loser_calc$research, na.rm = TRUE),
                                               mean(loser_calc$consulting, na.rm = TRUE),
                                               mean(loser_calc$fundraise, na.rm = TRUE),
                                               mean(loser_calc$pay, na.rm = TRUE),
                                               mean(loser_calc$materials, na.rm = TRUE),
                                               mean(loser_calc$travel, na.rm = TRUE),
                                               mean(loser_calc$event, na.rm = TRUE),
                                               mean(loser_calc$mail, na.rm = TRUE),
                                               mean(loser_calc$radio, na.rm = TRUE),
                                               mean(loser_calc$television, na.rm = TRUE),
                                               mean(loser_calc$newspaper, na.rm = TRUE),
                                               mean(loser_calc$smedia, na.rm = TRUE),
                                               mean(loser_calc$website, na.rm = TRUE)))

# calculate highest and lowest spending percentages by winner and loser
mean_spending_per[which.max(mean_spending_per$winner_mean),]
mean_spending_per[which.max(mean_spending_per$loser_mean),]
                                       
mean_spending_per[which.min(mean_spending_per$winner_mean),]
mean_spending_per[which.min(mean_spending_per$loser_mean),]   

# Scatterplot with Delta and Spending Total -------------------------------

winner_divide <- data.frame(delta = winner_calc$delta, 
                   total = winner_calc$total)
loser_divide <- data.frame(delta = loser_calc$delta, 
                            total = loser_calc$total)

winner_divide$total_divide <- winner_calc$total / 1000
loser_divide$total_divide <- loser_calc$total / 1000

ggplot(winner_divide, aes(x = delta, y = total_divide)) + 
  geom_point() + 
  geom_smooth(method = lm, se = FALSE) +
  ggtitle("Margin of Victory by Total Amount Spent") +
  labs(y="Total Amount Spent (in thousands)", x = "Delta (in %)")

ggplot(loser_divide, aes(x = delta, y = total_divide)) + 
  geom_point() + 
  geom_smooth(method = lm, se = FALSE) +
  ggtitle("Margin of Defeat by Total Amount Spent") +
  labs(y="Total Amount Spent (in thousands)", x = "Delta (in %)")

# Pie Charts --------------------------------------------------------------

# create two pie charts with spending breakdowns 
slices1 <- mean_spending_per$winner_mean
lbls1 <- c("advertise", "poll", "research", "consulting", "fundraise", 
          "pay", "materials", "travel", "event", "mail", "radio", 
          "television", "newspaper", "smedia", "website")
pie(slices1, labels = lbls1, main="Spending Breakdown, Winners",
    radius = 1, cex = 0.6)

slices2 <- mean_spending_per$loser_mean
lbls2 <- c("advertise", "poll", "research", "consulting", "fundraise", 
          "pay", "materials", "travel", "event", "mail", "radio", 
          "television", "newspaper", "smedia", "website")
pie(slices2, labels = lbls2, main="Spending Breakdown, Losers",
    radius = 1, cex = 0.6)

# Bar Chart ---------------------------------------------------------------

# bar chart comparison 
colnames(winner_calc)

# A. mean spending per chart ----------------------------------------------

# reshape your data into long format
meanlong <- melt(mean_spending_per, id=c("category"))

# make the plot - spending breakdown, campaign outcome
ggplot(meanlong) +
  geom_bar(aes(x = category, y = value, fill = variable), 
           stat="identity", position = "dodge", width = 0.7) +
  scale_fill_manual("Result\n", values = c("dark blue","blue"), 
                    labels = c("Winner", " Loser")) +
  labs(x="\nSpending Category",y="Percentage of Total Spending\n",
       title = "Spending Breakdown by Campaign Outcome") +
  theme(axis.text.x = element_text(face = "bold",size = 4))

# B. hold flip chart ------------------------------------------------------

# reshape your data into long format
mean_spending_hold_flip_divide <- mean_spending_hold_flip

mean_spending_hold_flip_divide$winner <- 
  mean_spending_hold_flip$winner / 1000
mean_spending_hold_flip_divide$loser <- 
  mean_spending_hold_flip$loser / 1000

meanlong2 <- melt(mean_spending_hold_flip_divide, id=c("hold_flip"))

# make the plot total spending, campaign outcome
ggplot(meanlong2) +
  geom_bar(aes(x = hold_flip, y = value, fill = variable), 
           stat="identity", position = "dodge", width = 0.7) +
  scale_fill_manual("Result\n", values = c("dark blue","blue"), 
                    labels = c("Winner", " Loser")) +
  labs(x="\nElection Outcome",y="Total Spending (in thousands)\n",
       title = "Total Spending by Campaign Outcome") +
  theme(axis.text.x = element_text(face = "bold",size = 10))

# C. mean spending party --------------------------------------------------

# reshape your data into long format
mean_spending_party_divide <- mean_spending_party

mean_spending_party_divide$winner <- 
  mean_spending_party$winner / 1000
mean_spending_party_divide$loser <- 
  mean_spending_party$loser / 1000

meanlong3 <- melt(mean_spending_party_divide, id=c("party"))

# make the plot total spending, campaign outcome
ggplot(meanlong3) +
  geom_bar(aes(x = party, y = value, fill = variable), 
           stat="identity", position = "dodge", width = 0.7) +
  scale_fill_manual("Result\n", values = c("dark blue","blue"), 
                    labels = c("Winner", " Loser")) +
  labs(x="\nPolitical Party",y="Total Spending (in thousands)\n",
       title = "Total Spending by Party") +
  theme(axis.text.x = element_text(face = "bold",size = 10))

# D. mean spending region  ------------------------------------------------

# reshape your data into long format
mean_spending_region_divide <- mean_spending_region

mean_spending_region_divide$winner <- 
  mean_spending_region$winner / 1000
mean_spending_region_divide$loser <- 
  mean_spending_region$loser / 1000

meanlong4 <- melt(mean_spending_region_divide, id=c("region"))

# make the plot total spending, campaign outcome
ggplot(meanlong4) +
  geom_bar(aes(x = region, y = value, fill = variable), 
           stat="identity", position = "dodge", width = 0.7) +
  scale_fill_manual("Result\n", values = c("dark blue","blue"), 
                    labels = c("Winner", " Loser")) +
  labs(x="\nRegion",y="Total Spending (in thousands)\n",
       title = "Total Spending by Region") +
  theme(axis.text.x = element_text(face = "bold",size = 10))

# E. mean spending totals  ------------------------------------------------

# reshape your data into long format
mean_spending_total_divide <- mean_spending_total

mean_spending_total_divide$winner <- 
  mean_spending_total$winner / 1000
mean_spending_total_divide$loser <- 
  mean_spending_total$loser / 1000

mean_spending_total_divide$total <- "total"

meanlong5 <- melt(mean_spending_total_divide, id=c("total"))

# make the plot total spending, campaign outcome
ggplot(meanlong5) +
  geom_bar(aes(x = total, y = value, fill = variable), 
           stat="identity", position = "dodge", width = 0.7) +
  scale_fill_manual("Result\n", values = c("dark blue","blue"), 
                    labels = c("Winner", " Loser")) +
  labs(x="\nCampaign Outcome",y="Total Spending (in thousands)\n",
       title = "Total Spending by Campaign Outcome") +
  theme(axis.text.x = element_text(face = "bold",size = 10))

# Correlations ------------------------------------------------------------

colnames(loser_calc)

correlations_per <- data.frame(category = c("advertise", "poll", 
                                               "research", "consulting",
                                               "fundraise", "pay", 
                                               "materials", "travel",
                                               "event", "mail", 
                                               "radio", "television", 
                                               "newspaper", "smedia", 
                                               "website"), 
                           winner = c(cor(winner_calc$delta, winner_calc$per_advertise, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_poll, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_research, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_consulting, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_fundraise, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_pay, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_materials, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_travel, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_event, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_mail, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_radio, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_television, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_newspaper, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_smedia, use = "complete.obs"),
                                     cor(winner_calc$delta, winner_calc$per_website, use = "complete.obs")),
                           loser = c(cor(loser_calc$delta, loser_calc$per_advertise, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_poll, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_research, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_consulting, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_fundraise, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_pay, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_materials, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_travel, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_event, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_mail, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_radio, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_television, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_newspaper, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_smedia, use = "complete.obs"),
                                     cor(loser_calc$delta, loser_calc$per_website, use = "complete.obs")))


# Linear Regression -------------------------------------------------------

# linear regression by 
lm_winner <- lm(delta ~ per_advertise + per_poll + per_research + per_consulting +
                  per_fundraise + per_pay + per_materials + per_travel + per_event +
                  per_mail + per_radio + per_television + per_newspaper + per_smedia +
                  per_website, 
                data = winner_calc)

# trim down 
lm_winner <- lm(delta ~ per_advertise + per_poll + per_research + per_consulting +
                  per_fundraise + per_pay + per_materials + per_travel + per_event +
                  per_mail, 
                data = winner_calc)
lm_winner
summary(lm_winner)

lm_winner_adv <- lm(delta ~ per_radio + per_television + per_newspaper, 
                data = winner_calc)
lm_winner_adv
summary(lm_winner_adv)

# Mapping along Spending Lines --------------------------------------------

# initialize 
state_abrev <- unique(winner_calc$state)
state_abrev <- sort(state_abrev)

# calculate total spending by state 
calc_state <- data.frame()

for(i in state_abrev){
  df1 <- subset(winner_calc, state == i)
  mean <- mean(df1$total, na.rm = TRUE)
  df2 <- data.frame("state" = df1$state[1], mean)
  calc_state <- rbind(calc_state, df2)
}

# plot 
plot_usmap(data = calc_state, values = "mean", lines = "red") + 
  scale_fill_continuous(
    low = "white", high = "red", name = "Total Spending", label = scales::comma
  ) + theme(legend.position = "right") + 
  labs(title = "Spending by State, with Montana")

# CREATE VERSION WITHOUT MONTANA

# initialize 
state_abrev <- as.data.frame(state_abrev)
state_abrev <- state_abrev[!grepl("MT", state_abrev$state_abrev),]

# calculate spending total 
calc_state <- data.frame()

for(i in state_abrev){
  df1 <- subset(winner_calc, state == i)
  mean <- mean(df1$total, na.rm = TRUE)
  df2 <- data.frame("state" = df1$state[1], mean)
  calc_state <- rbind(calc_state, df2)
}

# map 
plot_usmap(data = calc_state, values = "mean", lines = "red") + 
  scale_fill_continuous(
    low = "white", high = "red", name = "Total Spending", label = scales::comma
  ) + theme(legend.position = "right") + 
  labs(title = "Spending by State, without Montana")


# Box Plots ---------------------------------------------------------------

# Region
ggplot(winner_calc, aes(x=region, y=total)) + 
  geom_boxplot() +
  labs(title = "Mean Spending Distribution by Region, Winners",
       x = "Region",
       y = "Total Spending") 

ggplot(loser_calc, aes(x=region, y=total)) + 
  geom_boxplot() +
  labs(title = "Mean Spending Distribution by Region, Losers",
       x = "Region",
       y = "Total Spending")

# Party
ggplot(winner_calc, aes(x=party, y=total)) + 
  geom_boxplot() +
  labs(title = "Mean Spending Distribution by Party, Winners",
       x = "Party",
       y = "Total Spending")

ggplot(loser_calc, aes(x=party, y=total)) + 
  geom_boxplot() +
  labs(title = "Mean Spending Distribution by Party, Losers",
       x = "Party",
       y = "Total Spending")

# Hold Flip 
winner_calc %>% filter(is.na(hold_flip) == FALSE) %>% 
  ggplot(aes(x=hold_flip, y=total)) + 
  geom_boxplot() +
  labs(title = "Mean Spending Distribution by Outcome, Winners",
       x = "Outcome",
       y = "Total Spending") 

loser_calc %>% filter(is.na(hold_flip) == FALSE) %>% 
  ggplot(aes(x=hold_flip, y=total)) +
  geom_boxplot() +
  labs(title = "Mean Spending Distribution by Outcome, Losers",
       x = "Outcome",
       y = "Total Spending")

# T Tests -----------------------------------------------------------------

# t test for campaign outcome and total spending 
calc1 <- data.frame(campaign_outcome = 1:435, 
                    total = winner_calc$total)
calc2 <- data.frame(campaign_outcome = 1:343,
                    total = loser_calc$total)
calc1[,1] <- "win"
calc2[,1] <- "lose"

calc3 <- rbind(calc1, calc2)

t.test(calc3$total[calc3$campaign_outcome=="win"],
       calc3$total[calc3$campaign_outcome=="lose"])

# t test for party and total spending 

calc1 <- data.frame(party = winner_calc$party,
                    total = winner_calc$total)

t.test(calc1$total[calc1$party=="DEM"],
       calc1$total[calc1$party=="REP"])

# Chi Square Tests --------------------------------------------------------

# chi square for party and outcome of campaign 
calc_win <- data.frame(campaign_outcome = 1:435,
                           party = winner_calc$party,
                           total = winner_calc$total)
calc_win[,1] <- "win"

calc_lose <- data.frame(campaign_outcome = 1:343,
                       party = loser_calc$party,
                       total = loser_calc$total)
calc_lose[,1] <- "lose"

calc_outcome_party <- rbind(calc_win, calc_lose)

calc_outcome_party_table <- table(calc_outcome_party$campaign_outcome,
                                  calc_outcome_party$party)
chsq=chisq.test(calc_outcome_party_table)
chsq

# ANOVA -------------------------------------------------------------------

# hold flip 
calc1 <- data.frame(region = winner_calc$hold_flip, 
                    total = winner_calc$total)

results <- aov(total~region, data=calc1)  
summary(results)

# region
calc1 <- data.frame(region = winner_calc$region, 
                    total = winner_calc$total)

results <- aov(total~region, data=calc1)  
summary(results)



