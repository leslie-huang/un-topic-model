#!/usr/bin/env Rscript

# Leslie Huang

### Set up the workspace

args = commandArgs(trailingOnly=TRUE)

setwd(args[1])

load("un_base_workspace.RData")

set.seed(1234)

library("topicmodels")
library("parallel")
library("ldatuning")
#library("lda")
#library("quanteda")

num_cores <- max(1, parallel::detectCores() - 1)

controls_tm <- list(
  burnin = 1000,
  iter = 4000,
  thin = 500,
  nstart = 5,
  seed = 0:4,
  best = TRUE
)

result4 <- FindTopicsNumber(tm_dfm, topics = seq(50, 80, by = 1), metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"), mc.cores = num_cores, control = controls_tm, verbose = TRUE)

save.image("un_tuning.RData")