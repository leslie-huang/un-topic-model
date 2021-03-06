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

name <- "result_32"

assign(name, FindTopicsNumber(tm_dfm, topics = 32, metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"), mc.cores = num_cores, control = controls_tm, verbose = TRUE))

save.image("un_findk_32.RData")