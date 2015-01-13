# Complete all of the items below
# Use comments where you're having trouble or questions

# 1. Read your data set into R
# use read.csv() (read.delim() for tab-deliminated)
# 1. open in Excel
# 2. save as ... CSV

rm(list = ls()) # clear workspace

mydata <- read.csv("EEG_compiled.txt") # load EEG data from file


# 2. Peek at the top few rows

head(mydata) # look at top 6 rows of data


# 3. Peek at the top few rows for only a few columns

head(mydata[ ,c(1, 3, 5)]) # look at top 6 rows of data for columns 1, 3, and 5


# 4. How many rows does your data have?

length(mydata$subj) # gives number of rows for column "subj", all columns have the same number of rows

# my data has 2294400 rows

# 5. Get a summary for every column

summary(mydata)


# 6. Get a summary for one column

summary(mydata$amp)

# 7. Are any of the columns giving you unexpected values?
#    - missing values? (NA)

# yes, I thought all 37 subjects had 1050 timepoints in both conditions, 
# but the mean and median of the "time" column are too low
# after checking, it turns out that subjects 10, 41, 46, 47, and 4 only have 450 timepoints per condition


# 8. Select a few key columns, make a vector of the column names

column.names <- c("cond", "time", "amp")


# 9. Create a new data.frame with just that subset of columns
#    from #7
#    - do this in at least TWO different ways

mydata.subset1 <- data.frame(mydata[ ,c(2,4,5)])

mydata.subset2 <- data.frame(mydata$cond, mydata$time, mydata$amp)


# 10. Create a new data.frame that is just the first 10 rows
#     and the last 10 rows of the data from #8

mydata.firstlast <- data.frame(mydata.subset1[c(1:10, 2294391:2294400), ])



# 11. Create a new data.frame that is a random sample of half of the rows.

mydata.half <- data.frame(mydata.subset1[sample(nrow(mydata.subset1), 1147200), ])



# 12. Find a comparison in your data that is interesting to make
#     (comparing two sets of numbers)
#     - run a t.test for that comparison
#     - decide whether you need a non-default test
#       (e.g., Student's, paired)
#     - run the t.test with BOTH the formula and "vector"
#       formats, if possible
#     - if one is NOT possible, say why you can't do it


# compare amplitude between conditions (across all electrodes)

# it should be a paired t-test

condition1 <- mydata$amp[mydata$cond == 1]
condition2 <- mydata$amp[mydata$cond == 2]

test.cond_v <- t.test(condition1, condition2, paired = TRUE)

# formula t-test
# t.test(dependent variable ~ grouping factor, data = dataset you want)

test.cond_f <- t.test(amp ~ cond, data = mydata, paired = TRUE)


# 13. Repeat #10 for TWO more comparisons
#     - ALTERNATIVELY, if correlations are more interesting,
#       do those instead of t-tests (and try both Spearman and
#       Pearson correlations)

# compare amplitude between electrodes FZ(21) and PZ(4) in condition 1

FZ <- mydata$amp[mydata$cond == 1 & mydata$elec == 21]

PZ <- mydata$amp[mydata$cond == 1 & mydata$elec == 4]

test.elec_v <- t.test(FZ, PZ, paired = TRUE)

# test.elec_f <- t.test(amp ~ elec, data = mydata, paired = TRUE) 
# the formula format does not work here, because electrode has more than 2 levels

# compare amplitude of PZ(4) in condition 1 and 2

cond1 <- mydata$amp[mydata$elec == 4 & mydata$cond == 1]
cond2 <- mydata$amp[mydata$elec == 4 & mydata$cond == 2]

test.PZ_v <- t.test(cond1, cond2, paired = TRUE)

test.PZ_f <- t.test(amp ~ cond, data = mydata, paired = TRUE)
# I think I'm doing a t-test between conditions across all electrodes here, rather than just for PZ



# 14. Save all results from #12 and #13 in an .RData file

save(test.cond_v, test.cond_f, test.elec_v, test.PZ_v, test.PZ_f, file = "Zoe_day2_homework.RData")


# 15. Email me your version of this script, PLUS the .RData
#     file from #14
