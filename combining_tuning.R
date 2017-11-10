# Leslie Huang

# Combine all ldatuning results from cluster jobs

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "stringi", "topicmodels", "ldatuning", "lda")
lapply(libraries, require, character.only=TRUE)

load("../un_tuning_combined.RData")

results <- ls(pattern="^result_")

load("/Users/lesliehuang/Desktop/un_findk1.RData")

load("/Users/lesliehuang/Desktop/un_tuning.RData")

result <- rbind(result, result4)

for (r in results) {
  temp_df <- get(r)
  result <- rbind(result, temp_df)
}

result <- unique(result)

rm(model)
rm(result4)
rm(results)
rm(r)
rm(list = ls(pattern = "^result_"))

save.image("un_ldatuning_results.RData")
