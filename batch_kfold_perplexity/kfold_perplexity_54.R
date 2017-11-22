#!/usr/bin/env Rscript

# Leslie Huang

### Set up the workspace

args = commandArgs(trailingOnly=TRUE)

setwd(args[1])

set.seed(1234)

libraries <- c( "topicmodels", "foreach", "doParallel")
lapply(libraries, require, character.only=TRUE)

load("perplexity_k10_base.RData")

num_cores <- max(1, parallel::detectCores() - 1)
registerDoParallel(num_cores)

controls_tm <- list(
  burnin = 1000,
  iter = 4000,
  thin = 500,
  nstart = 1,
  seed = 0,
  best = TRUE
)

# Set up 10-fold cross-validation

perplexity_results_54 <- foreach (i = 1:num_folds, .combine = data.frame) %dopar% {
  tm_training <- get(paste("training_", i, sep = ""))
  tm_test <- get(paste("test_", i, sep = ""))
  
  train_model <- LDA(tm_training, k = 54, method = "Gibbs", control = controls_tm)
  perplexity <- perplexity(train_model, newdata = tm_test, method = "Gibbs", control = controls_tm)
  
}

save.image("kfold_perplexity_54.RData")