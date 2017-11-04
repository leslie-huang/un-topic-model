#!/usr/bin/env Rscript

# Leslie Huang

### Set up the workspace

args = commandArgs(trailingOnly=TRUE)

setwd(args[1])

load("un_img_new_dfm.RData")

set.seed(1234)

library("topicmodels")
#library("ldatuning")
#library("lda")
#library("quanteda")


# Run the topic model

model_75 <- LDA(tm_dfm, k = 75, control = list(seed = 1234))

save.image("un_img_new_dfm_75.RData")