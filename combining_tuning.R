# Leslie Huang

# Combine all ldatuning results from cluster jobs

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "stringi", "topicmodels", "ldatuning", "lda")
lapply(libraries, require, character.only=TRUE)

load("un_tuning_combined.RData")

results <- ls(pattern="^result_")

result <- result_100

for (r in results) {
  temp_df <- get(r)
  result <- rbind(result, temp_df)
}

ldatuning_results <- unique(result)

rm(results)
rm(r)
rm(list = ls(pattern = "^result_"))

save.image("un_ldatuning_results.RData")
