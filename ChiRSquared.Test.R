tbl <- table(ufo$MilitaryDist, ufo$MeterologicalDist)
chisq.test(tbl, simulate.p.value = TRUE)


# Output
# Pearson's Chi-squared test with simulated p-value (based on 2000 replicates)

# data:  tbl
# X-squared = 33041592, df = NA, p-value = 0.0004998