# Import Data -------------------------------------------------------------

# import 
library(readr)

calc_total <- read_csv("~/Desktop/stat_proj/coded_data/calc_total.csv", 
                       col_types = cols(X1 = col_skip()))
calc_polling <- read_csv("~/Desktop/stat_proj/coded_data/calc_polling.csv", 
                         col_types = cols(X1 = col_skip()))
calc_advertising <- read_csv("~/Desktop/stat_proj/coded_data/calc_advertising.csv", 
                             col_types = cols(X1 = col_skip()))
calc_research <- read_csv("~/Desktop/stat_proj/coded_data/calc_research.csv", 
                          col_types = cols(X1 = col_skip()))
calc_fundraising <- read_csv("~/Desktop/stat_proj/coded_data/calc_fundraising.csv", 
                             col_types = cols(X1 = col_skip()))
calc_payroll <- read_csv("~/Desktop/stat_proj/coded_data/calc_payroll.csv", 
                         col_types = cols(X1 = col_skip()))
calc_materials <- read_csv("~/Desktop/stat_proj/coded_data/calc_materials.csv", 
                           col_types = cols(X1 = col_skip()))
calc_consulting <- read_csv("~/Desktop/stat_proj/coded_data/calc_consulting.csv", 
                            col_types = cols(X1 = col_skip()))
calc_event <- read_csv("~/Desktop/stat_proj/coded_data/calc_event.csv", 
                       col_types = cols(X1 = col_skip()))
calc_salary <- read_csv("~/Desktop/stat_proj/coded_data/calc_salary.csv", 
                        col_types = cols(X1 = col_skip()))
calc_dmail <- read_csv("~/Desktop/stat_proj/coded_data/calc_dmail.csv", 
                       col_types = cols(X1 = col_skip()))
calc_travel <- read_csv("~/Desktop/stat_proj/coded_data/calc_travel.csv", 
                        col_types = cols(X1 = col_skip()))
calc_smedia <- read_csv("~/Desktop/stat_proj/coded_data/calc_smedia.csv", 
                        col_types = cols(X1 = col_skip()))
calc_radio <- read_csv("~/Desktop/stat_proj/coded_data/calc_radio.csv", 
                       col_types = cols(X1 = col_skip()))
calc_television <- read_csv("~/Desktop/stat_proj/coded_data/calc_television.csv", 
                            col_types = cols(X1 = col_skip()))
calc_fundraiser <- read_csv("~/Desktop/stat_proj/coded_data/calc_fundraiser.csv", 
                            col_types = cols(X1 = col_skip()))
calc_mailer <- read_csv("~/Desktop/stat_proj/coded_data/calc_mailer.csv", 
                        col_types = cols(X1 = col_skip()))
calc_postage <- read_csv("~/Desktop/stat_proj/coded_data/calc_postage.csv", 
                         col_types = cols(X1 = col_skip()))
calc_website <- read_csv("~/Desktop/stat_proj/coded_data/calc_website.csv", 
                         col_types = cols(X1 = col_skip()))
calc_wages <- read_csv("~/Desktop/stat_proj/coded_data/calc_wages.csv", 
                       col_types = cols(X1 = col_skip()))
calc_fgroup <- read_csv("~/Desktop/stat_proj/coded_data/calc_fgroup.csv", 
                        col_types = cols(X1 = col_skip()))
calc_newspaper <- read_csv("~/Desktop/stat_proj/coded_data/calc_newspaper.csv", 
                           col_types = cols(X1 = col_skip()))

# Combine Necessary Sets --------------------------------------------------

# Pay
calc_pay2 <- merge(calc_payroll, calc_salary, by = "committee_id", all = TRUE)
calc_pay2 <- merge(calc_pay2, calc_wages, by = "committee_id", all = TRUE)
calc_pay2$pay <- rowSums(cbind(calc_pay2$payroll, calc_pay2$salary, 
                               calc_pay2$wages), na.rm = TRUE)

calc_pay <- data.frame("committee_id" = calc_pay2$committee_id,
                       "pay" = calc_pay2$pay)

# Poll
calc_poll2 <- merge(calc_polling, calc_fgroup, by = "committee_id", all = TRUE)
calc_poll2$poll <- rowSums(cbind(calc_poll2$polling, calc_poll2$fgroup), na.rm = TRUE)

calc_poll <- data.frame("committee_id" = calc_poll2$committee_id,
                        "poll" = calc_poll2$poll)

# Advertise
calc_advertise2 <- merge(calc_advertising, calc_radio, by = "committee_id", all = TRUE)
calc_advertise2 <- merge(calc_advertise2, calc_television, by = "committee_id", all = TRUE)
calc_advertise2 <- merge(calc_advertise2, calc_newspaper, by = "committee_id", all = TRUE)
calc_advertise2$advertise <- rowSums(cbind(calc_advertise2$advertising,
                                           calc_advertise2$radio,
                                           calc_advertise2$television,
                                           calc_advertise2$newspaper), na.rm = TRUE)

calc_advertise <- data.frame("committee_id" = calc_advertise2$committee_id,
                             "advertise" = calc_advertise2$advertise)

# Fundraise
calc_fundraise2 <- merge(calc_fundraising, calc_fundraiser, by = "committee_id", all = TRUE)
calc_fundraise2$fundraise <- rowSums(cbind(calc_fundraise2$fundraising, 
                                           calc_fundraise2$fundraiser), na.rm = TRUE)

calc_fundraise <- data.frame("committee_id" = calc_fundraise2$committee_id,
                             "fundraise" = calc_fundraise2$fundraise)

# Mail 
calc_mail2 <- merge(calc_dmail, calc_mailer, by = "committee_id", all = TRUE)
calc_mail2 <- merge(calc_mail2, calc_postage, by = "committee_id", all = TRUE)
calc_mail2$mail <- rowSums(cbind(calc_mail2$dmail, calc_mail2$mailer, 
                                 calc_mail2$postage), na.rm = TRUE)

calc_mail <- data.frame("committee_id" = calc_mail2$committee_id,
                        "mail" = calc_mail2$mail)

# Merge Data Frames -------------------------------------------------------

# merge all sets 
calc_combine <- NA
calc_combine <- merge(calc_total, calc_advertise, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_poll, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_research, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_fundraise, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_pay, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_materials, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_consulting, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_event, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_mail, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_travel, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_smedia, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_radio, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_television, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_website, by = "committee_id", all = TRUE)
calc_combine <- merge(calc_combine, calc_newspaper, by = "committee_id", all = TRUE)

# export as csv 
write.csv(calc_combine, "calc_combine.csv")
