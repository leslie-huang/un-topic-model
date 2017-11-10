# Leslie Huang

# Combine all ldatuning results from cluster jobs

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "stringi", "topicmodels", "ldatuning", "lda", "caret")
lapply(libraries, require, character.only=TRUE)

load("un_ldatuning_results.RData")
load("../Dropbox/un_models.RData")

num_cores <- max(1, parallel::detectCores() - 1)

controls_tm <- list(
  burnin = 1000,
  iter = 4000,
  thin = 500,
  nstart = 5,
  seed = 0:4,
  best = TRUE
)

dfm_training <- dfm_sample(un_dfm, size = ndoc(un_dfm) * .9, replace = FALSE)

dfm_test <- dfm_select(un_dfm, documents = docnames(dfm_training), selection = "remove")

tm_training <- convert(dfm_training, to = "topicmodels")
tm_test <- convert(dfm_test, to = "topicmodels")

save.image("perplexity_base.RData")
