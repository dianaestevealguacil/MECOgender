# Gender Analysis of the MECO
# Diana Esteve Alguacil
# 01/07/2024
# Last updated 09/07



####### Trimming the data (L2 data)####### 
rm(list = ls(all = TRUE))

library(ggplot2)
library(tidyverse)
library(psych)
library(xtable)
library(plyr)
library(cowplot)
library(dplyr)
library(lme4)
library(lattice)
library(MASS)


#### read L2 data ##
load("MECO L2 data version 1.1/primary data/eye tracking data/joint_data_l2_trimmed.rda")

l2.data = joint.data
rm(joint.data)

###### remove outliers ###########

l2.data = l2.data[l2.data$dur > 80 | is.na(l2.data$dur)==T,]

crit = l2.data %>%
  dplyr::group_by(lang, uniform_id) %>%
  dplyr::summarise(dur.crit = quantile(dur, 0.99, na.rm = T))

m = merge(l2.data, crit, by.x = c("lang", "uniform_id"), by.y = c("lang", "uniform_id"))  
m = m[m$skip == 1 | (m$dur < m$dur.crit),]

m -> l2.data
rm(m)


l2.data = l2.data[l2.data$skip == 1 | l2.data$nfix <= quantile(l2.data$nfix, 0.99, na.rm = T), ]
l2.data$nfix.inc = 0 #fixing NAs in nfix for skipped words. Replacing by 0s.
l2.data[is.na(l2.data$nfix) == F,]$nfix.inc = l2.data[is.na(l2.data$nfix) == F,]$nfix


summary(l2.data$nfix.inc)
#this is just some trimming and formatting. 

#adding word length

l2.data$ia_mod = gsub("[[:punct:]]", "", l2.data$ia)

l2.data$length = nchar(l2.data$ia_mod) ### this way we get length


####getting per trial l2 skipping data with per subject l1 skipping

load("MECO L2 data version 1.1/auxiliary files/by-sub-means/by.sub.l1.rda")
by.sub1 -> by.sub.l1
colnames(by.sub.l1) = paste0("l1_", colnames(by.sub.l1))
rm(by.sub1)

by.sub.l1 = by.sub.l1[, 1:3]
by.sub.l1$uniform_id = by.sub.l1$l1_uniform_id

by.sub.l1 = by.sub.l1[, -1]


l2.data.merged = merge(l2.data, by.sub.l1, by.x = c("uniform_id"), by.y = c("uniform_id"))  

#now I have per trial l2 skipping data with per subject l1 skipping

#now we have data by subject!





#getting mean word length per language
load("version 1.0/primary data/eye tracking data/joint_data_trimmed.rda") #data frame after low-quality participants and trials are removed.

# remove outliers by language and participant

joint.data = joint.data[joint.data$dur > 80 | is.na(joint.data$dur)==T,]
#This means, create the new data with data that is either less than 80 in duration, OR is a NA in duration!


crit = ddply(joint.data, c("lang", "uniform_id"), dplyr::summarise,
             dur.crit = quantile(dur, 0.99, na.rm = T))

#This means, split me the data frame, create me a new dataframe called crit that is composed of the results of the function. 
#So here I am creating a data frame based only on the language and uniform_id columns (where they match, i assume), and then summarizing also the dur.crit column, 
#ignoring missing values, and to the 99 percentile.
#So basically, just for the columns of lang and uniform_id, summarize their dur.crit. Having a bit of trouble here with dur.crit and the quantiles.

m = merge(joint.data, crit, by.x = c("lang", "uniform_id"), by.y = c("lang", "uniform_id"))

#Here I'm creating a new dataframe joining joint.data and crit, by the common columns lang and uniform_id. 
#This is by for more than one variables, to ensure that we are putting the thing in the row that matches with both values.



m = m[m$skip == 1 | (m$dur < m$dur.crit),]
#Here they are eliminating results that are not skip ==1  OR that their dur is less than crit. 
#They are removing either skipped or the ones that took too long


m -> joint.data
rm(m)

joint.data = joint.data[is.na(joint.data$lang)==F,]
#removing missing values in rows of lang (removed 1 value)

joint.data = joint.data[joint.data$skip == 1 | joint.data$nfix <= quantile(joint.data$nfix, 0.99, na.rm = T), ]
#here they are doing the same but with nfix. Dropped to people who either skipped, or have max 6 fixations 


joint.data$ia_mod = gsub("[[:punct:]]", "", joint.data$ia)
#here im replacing the thing between brackets for "", in the data$ia column. I think its trying to remove punctuation?
joint.data$len = nchar(joint.data$ia_mod)
#here its trying to figure out the length basically, and create a new column with it
describeBy(joint.data$len, group = joint.data$lang, mat = T) -> desc.len
#we create descriptive statistics for word length per language, and make it a new dataframe

desc.len = dplyr::rename(desc.len, var = item)
desc.len = dplyr::rename(desc.len, lang = group1)
desc.len$var = "word length"

desc.len = desc.len[,c(2,1,4,5,6,15,7,10,11)]

table_data = rbind(table_data, desc.len)

for (i in 3:ncol(table_data)) {
  table_data[,i] = round(table_data[,i], 3)}

sub_data = l2.data.merged %>%                              # Applying group_by & summarise
  group_by(lang) %>%
  dplyr::summarise(num_sub = n_distinct(uniform_id))




table_data = merge(table_data, sub_data, by.x = c("lang"), by.y = c("lang"))  
table_data = table_data[order(table_data$var),]


####getting L1 data###
# Upload data and descriptive stats #
load("MECO L1 data version 1.2/primary data/eye tracking data/joint_data_trimmed.rda") #data frame after low-quality participants and trials are removed.

l1.data = joint.data
#remove outliers by language and participant

l1.data = l1.data[l1.data$dur > 80 | is.na(l1.data$dur)==T,]

crit = ddply(l1.data, c("lang", "uniform_id"), summarise,
             dur.crit = quantile(dur, 0.99, na.rm = T))

m = merge(l1.data, crit, by.x = c("lang", "uniform_id"), by.y = c("lang", "uniform_id"))  
m = m[m$skip == 1 | (m$dur < m$dur.crit),]

m -> l1.data
rm(m)

l1.data = l1.data[is.na(l1.data$lang)==F,]
l1.data = l1.data[l1.data$skip == 1 | l1.data$nfix <= quantile(l1.data$nfix, 0.99, na.rm = T), ]


### note re-labeling of variables:
# skipping (in popeye: skip), firstFixationDuration (firstfix.dur), gaze duration (firstrun.dur), total fixation duration (dur), first run number of fixations (firstrun.nfix), total number of fixations (nfix), regression (reg.in), rereading. Then CFT.  

by.sub = ddply(l1.data, c("uniform_id", "lang"), summarise,
               skipping = mean(skip, na.rm = T),
               firstFixationDuration = mean(firstfix.dur, na.rm = T),
               gazeDuration = mean(firstrun.dur, na.rm = T),
               totalFixationDuration = mean(dur, na.rm = T),
               nFixationsFirstRun = mean(firstrun.nfix, na.rm = T),
               nFixationsTotal = mean(nfix, na.rm = T),
               regressionIn = mean(reg.in, na.rm = T),
               rereading = mean(reread, na.rm = T))

load("../primary data/eye tracking data/joint.readrate.rda") #reading rate broken down by story and participant
u -> readrate_full
rm(u)

colnames(readrate_full)[colnames(readrate_full) == "rate"] <- "readingRate" #change label

readrate_full <- readrate_full %>% filter(readingRate < 1000)

readrate <- readrate_full %>% group_by(uniform_id) %>% dplyr::summarize(readingRate = mean(readingRate))

by.sub = by.sub[is.na(by.sub$lang)==F,]

m = merge(by.sub, readrate)
m -> by.sub
rm(m, readrate)

u <- unique(l1.data[, c("lang", "uniform_id", "trialid")])
x <- unique(by.sub[, c("lang", "uniform_id")])

data.frame(rbind(table(by.sub$lang), table(l1.data$lang),
                 round(100*rowMeans(table(u$lang, u$trialid))/table(by.sub$lang)))) -> stats_parts
stats_parts = data.frame(t(stats_parts))
colnames(stats_parts) = c("N subjects", "N trials", "Trials after trimming, %")
xtable(stats_parts, caption = "Number of participants and percent of trials retained after data cleaning", label = "tab:statsparts", digits = 0) -> tab1
print(tab1)

load("MECO L1 data version 1.2/primary data/comprehension data/joint_l1_acc.rda") #uploading comprehension accuracy data.

colnames(joint.acc)[colnames(joint.acc) == "accuracy_matched"] <- "accuracyMatched" #just to change format of label

joint.acc$lang = as.factor(joint.acc$lang)

describeBy(joint.acc[, c("accuracy", "accuracyMatched")], group = joint.acc$lang) -> desc_acc
data.frame(do.call(rbind, desc_acc)) -> desc_acc
substr(rownames(desc_acc), 1, 2) -> desc_acc$lang
substr(rownames(desc_acc), 4, nchar(rownames(desc_acc))) -> desc_acc$var
desc_acc <- desc_acc[, c("var", "lang", "n", "mean", "sd", "se",  "median", "min", "max")]
desc_acc = desc_acc[order(desc_acc$var, desc_acc$lang),]

for (i in 3:ncol(desc_acc)) {
  desc_acc[,i] = round(desc_acc[,i], 2)
}

rownames(desc_acc) = 1:nrow(desc_acc)
desc_acc = droplevels(desc_acc)

cft <- read.csv("../primary data/individual differences data/cft.summary.csv", T) #CFT non-verbal intelligence data.
cft$cft20 -> cft$cft_score
cft$cft20 <- NULL
describeBy(cft[, c("cft_score")], group = cft$lang) -> desc_cft
data.frame(do.call(rbind, desc_cft)) -> desc_cft

substr(rownames(desc_cft), 1, 2) -> desc_cft$lang
desc_cft$var <- "cft"
desc_cft <- desc_cft[, c("var", "lang", "n", "mean", "sd", "se",  "median", "min", "max")]
desc_cft = desc_cft[order(desc_cft$var, desc_cft$lang),]


descr <- data.frame(rbind(descr, desc_acc, desc_cft), stringsAsFactors = F)
rm(desc_acc, desc_cft)
descr$lang = as.factor(descr$lang)
# write.csv(descr, "../auxiliary files/descriptive stats/descriptive_eyemove_language.csv", quote = F, row.names = F)


####### Gender Analysis ##########

