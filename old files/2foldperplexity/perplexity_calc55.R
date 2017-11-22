#!/usr/bin/env Rscript

# Leslie Huang

### Set up the workspace

args = commandArgs(trailingOnly=TRUE)

setwd(args[1])

load("perplexity_base.RData")

set.seed(1234)

library("topicmodels")
#library("parallel")
#library("ldatuning")
#library("lda")
#library("quanteda")

controls_tm <- list(
  burnin = 1000,
  iter = 4000,
  thin = 500,
  nstart = 1,
  seed = 0
)

train_55 <- LDA(tm_training, k = 55, method = "Gibbs", control = controls_tm)

save.image("perplexity_55.RData")
