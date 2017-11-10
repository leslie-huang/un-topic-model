# Replication info for "un_ldatuning_results.RData"
# Using batch jobs on the High Performance Computing Cluster

# Starts with:
# un_base_workspace.RData

# Combined resulting workspace images from the following scripts:

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

ldatuning_results <- FindTopicsNumber(tm_dfm, topics = seq(40, 100, by = 10), metrics = c("Griffiths2004", "CaoJuan2009", "Arun2010", "Deveaud2014"), mc.cores = num_cores, control = controls_tm, verbose = TRUE)

# Plus additional batch jobs run separately for single values of k

# Using the combining_tuning.R script