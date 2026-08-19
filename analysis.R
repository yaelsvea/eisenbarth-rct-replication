# ============================================================
# Replication + extension: Eisenbarth, Graham & Rigterink (2021)
# "Can Reminders of Rules Induce Compliance?"
# ============================================================

library(fixest)

hh <- read.csv("data/household_data_rules.csv")

# 18 controls used in the paper's household-level regressions
covars <- c("cvl_housesex","cvl_houseage","cvl_resp_school","cvl_frac_tribe",
            "cvl_houseborn","cvl_adult_fem","cvl_borderforest","cvl_cfmmember",
            "cvl_cfmage","cvl_matbiz","cvl_landarea","cvl_villagesize",
            "cvl_timetofinancialfoot","cvl_mintimemarket","cvl_distkampala",
            "cvl_Panga","cvl_Chainsaw","cvl_building")

# ============================================================
# PART 1: Belief outcome - perceived sanction probability
# Replicates Table 4, Column 3
# ============================================================

# build baseline lag for the outcome (not pre-lagged like the covariates)
baseline <- hh[hh$time == 0, c("hh_id", "penlikely")]
names(baseline)[2] <- "lag_penlikely"
hh <- merge(hh, baseline, by = "hh_id", all.x = TRUE)

form <- as.formula(paste("penlikely ~ mon + rules_vil + lag_penlikely +",
                         paste(covars, collapse = " + "),
                         "| clusternumber"))

m <- feols(form, data = subset(hh, time == 1), cluster = ~village)
summary(m)

# joint test of mon + rules_vil (paper's reported beta1+beta2)
b <- coef(m)
V <- vcov(m)
lincom_est <- b["mon"] + b["rules_vil"]
lincom_se  <- sqrt(V["mon","mon"] + V["rules_vil","rules_vil"] + 2*V["mon","rules_vil"])
lincom_est
lincom_se
2 * pt(-abs(lincom_est/lincom_se), df = m$nparams)

# ============================================================
# PART 2: Behavior outcome - non-compliance with forest rules
# Replicates Table 5, Column 1 - did belief change turn into behavior change?
# ============================================================

baseline <- hh[hh$time == 0, c("hh_id", "h18_break_rules")]
names(baseline)[2] <- "lag_h18_break_rules"
hh <- merge(hh, baseline, by = "hh_id", all.x = TRUE)

form2 <- as.formula(paste("h18_break_rules ~ mon + rules_vil + lag_h18_break_rules +",
                          paste(covars, collapse = " + "),
                          "| clusternumber"))

m2 <- feols(form2, data = subset(hh, time == 1), cluster = ~village)
summary(m2)

# ============================================================
# PART 3: My extension - does the SMS effect vary for households
# that border the forest directly?
# ============================================================

form3 <- as.formula(paste("penlikely ~ mon + rules_vil + rules_vil:cvl_borderforest + lag_penlikely +",
                          paste(covars, collapse = " + "),
                          "| clusternumber"))

m3 <- feols(form3, data = subset(hh, time == 1), cluster = ~village)
summary(m3)
