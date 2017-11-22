#!/usr/bin/env Rscript

# Leslie Huang

### Set up the workspace

args = commandArgs(trailingOnly=TRUE)

setwd(args[1])
k <- int(args[2])
i <- int(args[3])

set.seed(1234)

libraries <- c( "topicmodels", "foreach", "doParallel")
lapply(libraries, require, character.only=TRUE)

load("perplexity_k10_base.RData")

controls_tm <- list(
  burnin = 1000,
  iter = 4000,
  thin = 500,
  nstart = 1,
  seed = 0,
  best = TRUE
)

# Set up 10-fold cross-validation
tm_training <- get(paste("training_", i, sep = ""))
tm_test <- get(paste("test_", i, sep = ""))
  
train_model <- LDA(tm_training, k = 40, method = "Gibbs", control = controls_tm)
name <- paste("kfold_perplexity", k, i, sep = "_")
assign(name, perplexity(train_model, newdata = tm_test, method = "Gibbs", control = controls_tm))

save(paste(name, ".RData"))