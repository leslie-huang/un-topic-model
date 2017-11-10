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
  nstart = 5,
  seed = 0:4,
  best = TRUE
)

train_65 <- LDA(tm_training, k = 65, method = "Gibbs", control = controls_tm)

perplexity_65 <- perplexity(train_65, newdata = tm_test, control = controls_tm)
save.image("perplexity_test.RData")

train_75 <- LDA(tm_training, k = 75, method = "Gibbs", control = controls_tm)

perplexity_75 <- perplexity(train_75, newdata = tm_test, control = controls_tm)
save.image("perplexity_test.RData")

perplexity_55 <- perplexity(train_55, newdata = tm_test, control = controls_tm)

train_55 <- LDA(tm_training, k = 55, method = "Gibbs", control = controls_tm)


#flds <- createFolds(un_dfm, k = 5, list = TRUE)

#perplexity_50 <- perplexity(model_50, newdata = tm_dfm, control = list(seed = 0))

save.image("perplexity_test.RData")
