# Leslie Huang

# Combine all ldatuning results from cluster jobs

### Set up the workspace
rm(list=ls())
setwd("/Users/lesliehuang/un-analysis/")

set.seed(1234)

libraries <- c("foreign", "utils", "dplyr", "plyr", "devtools", "quanteda", "stringi", "topicmodels", "ldatuning", "lda", "caret")
lapply(libraries, require, character.only=TRUE)

load("un_base_workspace.RData")

num_cores <- max(1, parallel::detectCores() - 1)

controls_tm <- list(
  burnin = 1000,
  iter = 4000,
  thin = 500,
  nstart = 5,
  seed = 0:4,
  best = TRUE
)

# Set up 10-fold cross-validation

fold_size <- floor(ndoc(un_dfm) * .1)
num_folds <- 10
indices <- sample(ndoc(un_dfm))
split_indices <- split(indices, 1:num_folds)

for (i in 1:num_folds) {
  indices <- unlist(split_indices[i])
  test_name <- paste("test_", i, sep = "")
  training_name <- paste("training_", i, sep = "")
  
  assign(test_name, convert(un_dfm[indices], to = "topicmodels"))
  assign(training_name, convert(un_dfm[-indices], to = "topicmodels"))
  
  
}

save.image("perplexity_k10_base.RData")
