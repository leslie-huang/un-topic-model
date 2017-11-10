#!/usr/bin/env Rscript

# Leslie Huang

### Set up the workspace

args = commandArgs(trailingOnly=TRUE)

setwd(args[1])

load("un_base_workspace.RData")

set.seed(1234)

#library("quanteda")
library("topicmodels")
#library("ldatuning")
#library("lda")


# Run the topic model


# set controls
controls_tm <- list(
  burnin = 1000,
  iter = 4000,
  thin = 500,
  nstart = 5,
  seed = 0:4,
  best = TRUE
)


model_80 <- LDA(tm_dfm, k = 80, method = "Gibbs", control = controls_tm)

save.image("un_model_80.RData")