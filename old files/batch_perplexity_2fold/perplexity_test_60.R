#!/usr/bin/env Rscript

# Leslie Huang

### Set up the workspace

args = commandArgs(trailingOnly=TRUE)

setwd(args[1])

load("perplexity_60.RData")

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

perplexity_test_60 <- perplexity(train_60, newdata = tm_test, control = controls_tm)

save.image("perplexitytest_60.RData")
